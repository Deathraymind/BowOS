import subprocess
import asyncio
from textual.app import App, ComposeResult
from textual.containers import Container
from textual.widgets import Header, Footer, Button, Label, Input, Static
from textual.reactive import Reactive
from textual.message import Message

class DiskFormatterApp(App):

    password_mismatch_label: Reactive[str] = Reactive("")

    def compose(self) -> ComposeResult:
        yield Label("Available disks and partitions:")
        yield Label(self.get_disks(), id="disk_list")
        yield Input(placeholder="Enter the disk to format (e.g., /dev/sda)", id="disk_input")
        yield Label("", id="status_label")
       
        # User Creation
        yield Input(placeholder="Username", id="username_input")
        yield Label("", id="password_mismatch_label")
        yield Input(placeholder="Password", id="password_input", password=True)
        yield Input(placeholder="Confirm Password", id="confirm_password_input", password=True)

        yield Button("Proceed with Formatting", id="proceed_button")
        

        # Output view
        yield Container(Static("Terminal output will appear here.", id="output_view"), id="output_container")
        yield Footer()

    def get_disks(self) -> str:
        """Get the available disks and partitions using lsblk."""
        result = subprocess.run(['lsblk'], capture_output=True, text=True)
        return result.stdout

    async def on_input_changed(self, message: Message) -> None: # on_input_changed is a hook method
        password = self.query_one("#password_input").value
        confirm_password = self.query_one("#confirm_password_input").value
        if password != confirm_password:
            self.query_one("#password_mismatch_label", Label).update("Passwords do not match!")
        else:
            self.query_one("#password_mismatch_label", Label).update("Passwords match!")

    def on_button_pressed(self, event):
        if event.button.id == "proceed_button":
            disk = self.query_one("#disk_input", Input).value
            if not disk.strip():
                self.query_one("#status_label", Label).update("Invalid disk!")
            else:
                self.query_one("#status_label", Label).update("Starting disk formatting...")
                asyncio.create_task(self.format_disk(disk))  # Run disk formatting asynchronously

    async def run_command(self, command: str) -> str:
        """Run a shell command and return the output."""
        process = await asyncio.create_subprocess_shell(command, 
                                                        stdout=subprocess.PIPE, 
                                                        stderr=subprocess.PIPE)
        stdout, stderr = await process.communicate()
        return stdout.decode() + stderr.decode()

    async def append_output(self, text: str):
        """Append text to the terminal output view, showing only the last 5 lines."""
        if not hasattr(self, 'last_lines'):
            self.last_lines = []
        
        # Add the new line to the list
        self.last_lines.append(text)
        # Ensure the list only contains the last 5 lines
        if len(self.last_lines) > 5:
            self.last_lines.pop(0)
        # Join the lines and update the output view
        output_view = self.query_one("#output_view", Static)
        output_view.update("\n".join(self.last_lines))

  async def format_disk(self, disk: str):
    """Format the disk and create partitions."""
    try:
        # Determine if the disk is an NVMe drive
        is_nvme = "nvme" in disk

        # Define the partition suffix
        partition_suffix = "p" if is_nvme else ""

        await self.append_output(f"Unmounting {disk}...")
        await self.run_command(f"sudo umount -l {disk}")
        await self.run_command(f"sudo umount -l {disk}{partition_suffix}1")
        await self.run_command(f"sudo umount -l {disk}{partition_suffix}2")
        await self.run_command(f"sudo umount -l {disk}{partition_suffix}3")

        await self.append_output("Creating partitions...")
        await self.run_command(f"parted --script {disk} -- mklabel gpt")
        await self.run_command(f"parted --script {disk} -- mkpart root ext4 512MiB -8GB")
        await self.run_command(f"parted --script {disk} -- mkpart swap linux-swap -8GB 100%")
        await self.run_command(f"parted --script {disk} -- mkpart ESP fat32 1MiB 512MiB")
        await self.run_command(f"parted --script {disk} -- set 3 esp on")

        await self.append_output("Formatting partitions...")
        await self.run_command(f"mkfs.ext4 -F -L nixos {disk}{partition_suffix}1")
        await self.run_command(f"mkswap -L swap {disk}{partition_suffix}2")
        await self.run_command(f"mkfs.fat -F 32 -n boot {disk}{partition_suffix}3")

        await self.append_output("Mounting filesystems...")
        await self.run_command(f"mount /dev/disk/by-label/nixos /mnt")
        await self.run_command(f"mkdir -p /mnt/boot")
        await self.run_command(f"mount -o umask=007 /dev/disk/by-label/boot /mnt/boot")

        # Run the disk_formatter.sh script and capture its output in real-time
        await self.run_command(f"export BOWOS_USER={self.query_one('#username_input', Input).value}")
        await self.run_command(f"export BOWOS_PASSWORD={self.query_one('#password_input', Input).value}")
        process = await asyncio.create_subprocess_shell(
            'bash ./disk_formatter.sh',
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE
        )

        while True:
            line = await process.stdout.readline()
            if not line:
                break
            await self.append_output(line.decode().strip())

        while True:
            line = await process.stderr.readline()
            if not line:
                break
            await self.append_output(line.decode().strip())

        await process.wait()

        # Read the log file and append its contents to the output view
        with open('/mnt/disk_formatter.log', 'r') as log_file:
            for line in log_file:
                await self.append_output(line.strip())

        self.query_one("#status_label", Label).update("Disk formatted and mounted successfully!")
    except Exception as e:
        await self.append_output(f"An error occurred: {e}")
        self.query_one("#status_label", Label).update(f"Error: {e}") 
if __name__ == "__main__":
    app = DiskFormatterApp()
    app.run()

