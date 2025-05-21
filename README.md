<p align="center">
  <img src="/assets/banner.png" width="100%">
</p>

<p align="center">
  <a href="https://www.raspberrypi.com/products/"><img src="https://img.shields.io/badge/Tested%20on-Raspberry%20Pi%20-c51a4a" alt="Raspi"></a>
  <a href="https://www.raspberrypi.com/software/"><img src="https://img.shields.io/badge/supports-raspbian-red" alt="raspbian"></a>
  <a href="https://www.raspberrypi.com/software/"><img src="https://img.shields.io/badge/kernel-64bit-blue" alt="kernel"></a>  
  <a href="https://ubuntu.com/download/raspberry-pi"><img src="https://img.shields.io/badge/supports-ubuntu%20RT-orange" alt="ubuntu"></a>
  <a href="https://github.com/neurobionics/robot-ci/actions/workflows/build.yml"><img src="https://github.com/neurobionics/robot-ci/actions/workflows/build.yml/badge.svg" alt="build"></a>
</p>

**Robot CI**: Effortless building, testing, and deploying customized robot operating systems at scale. This tool lets you **version control your entire robot OS configuration and makes remote development a breeze**.

## 🎯 Key Features

This tool solves common challenges in robotics development:

| Feature | Description |
|---------|-------------|
| **Version-Controlled OS** | Track and manage your robot environment in code, enabling reproducible builds with GitHub Actions, and allowing for easy rollbacks and collaboration. |
| **Remote Development** | Provides optimized headless server images with automatic IP notifications via email, facilitating seamless remote development. |
| **Customizable Environment** | Allows for the pre-installation of drivers and custom packages, and the configuration of services and boot sequences to tailor the environment to specific needs. |
| **Network Auto-Config** | Automatically connects to WiFi networks and establishes a fallback access point when no WiFi networks are available, ensuring continuous connectivity. |

## 👥 Ideal for Developers Who
- Want to **streamline the RPi setup process** for students, teams, interns, etc.
- Desire a **version-controlled robot environment**.
- Require **reproducible** development setups.
- Prefer **remote development** over manual RPi configuration.
- **Manage multiple robots** with similar configurations.

## 🛠️ Example Use Cases
- **Research labs** managing multiple test platforms or robots
- Robotics companies **deploying a fleet of robots**
- Educational institutions maintaining **student robots for course projects**
- Development teams needing **consistent robot environments** across multiple robots

> [!NOTE]
> Currently tested on Raspberry Pi 4 and 5. May not be compatible with Raspberry Pi Zero.

## Getting Started
If you're unfamiliar with GitHub, we recommend their tutorials available on [GitHub's YouTube channel](https://www.youtube.com/@GitHub)

### 1. Repository Setup
You have two options to use this repository:

1. **Fork the Repository** (Recommended)
   - Click the "Fork" button at the top of this repository
   - Maintains connection to the original repository
   - Useful if you want to receive future updates and contribute back

2. **Use as a Template**
   - Click the green "Use this template" button at the top of this repository
   - This creates a new repository with a clean history
   - Best for starting your own customized version

Choose the option that best suits your needs:
- Choose **Fork** if you want to stay updated with the original repository's changes
- Choose **Template** if you want a clean slate for your own project

### 2. Secrets Setup

The next step is to create the secrets that securely handle sensitive information. These secrets will be added to the image configuration when running the workflow. To add secrets, navigate to the Settings tab, and select **Secrets and variables**, and select Actions. Create each of the following secrets, making sure to use the same variable naming:

| Secret | Purpose |
|--------|---------|
| `EMAIL_ADDRESS` | Email address(es) to send notifications to; separate multiple addresses with commas **("," and not ", ")** |
| `ENTNETWORK_SSID` | Enterprise (e.g. university) wifi network name |
| `ENTNETWORK_IDENTITY` | Network username |
| `ENTNETWORK_PASSWORD` | Network password |
| `ENTNETWORK_PRIORITY` | Choose connection priority (e.g. a number greater than five will be higher priority; higher is greater priority) |
| `SMTP_SERVER` | SMTP server for email notifications, for Gmail use `smtp.gmail.com` |
| `SMTP_USERNAME` | Username for the email account that will send notifications |
| `SMTP_PASSWORD` | Password for the email account that will send notifications |
| `WIFI_COUNTRY_CODE` | WiFi country code, defaults to US if not set |

Optional secrets:

| Secret | Purpose |
|--------|---------|
| `TIMEZONE` | Timezone for the device, defaults to America/New_York if not set |
| `KEYBOARD_LAYOUT` | Keyboard layout, defaults to us if not set |
| `KEYBOARD_MODEL` | Keyboard model, defaults to pc105 if not set |

### 3. Build Your Image
1. Navigate to the **Actions** tab, enable workflows by clicking on the green button, and then select **Build** from the left hand side
2. Click the **Run Workflow** button and select your build options:
   - Choose between `raspbian` (default) or `ubuntu`
   - Provide your `admin password` and `user password`. Users are created based on the `EMAIL_ADDRESS` secret, for example, if `EMAIL_ADDRESS` secret is set to "user1@example.com,user2@example.com", two users will be created: "user1" and "user2" and the first user will be considered the admin and all other users will be considered regular users.
   - Configure WiFi settings for additional home networks
   - Be sure to record this information--you will need it (e.g. access point login info)
   - ☕ Grab a cup of coffee. This process takes about ten minutes
3. Once the build is complete, click on the **build**, and the OS image will be available as an artifact in the Actions tab. It will be a .zip file available for download. 

### 4. Deploy & Connect
1. Download and flash the image to an SD card using [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
   - Select your RPi hardware version number in the Raspberry Pi Imager
   - Choose the Operating System, scroll to the last option, and select **Use custom**
   - Browse to the custom image recently downloaded from your image build
   - Select the SD card as the storage medium
   - Select No to 'Apply OS customization options?' 
3. Boot your RPi. Please use a 15-25+ W power supply (e.g not a low-power PC USB port) to ensure proper RPi functionality
> [!NOTE]
> **First Boot**: After powering on your Raspberry Pi for the first time, wait 5 minutes and then power off and on again. This first boot will not send an email. Please power cycle after five minutes for the email and network services to be available. This is only required for the first boot.
3. Connect via:
   - Enterprise or Home network: Check your email for the IP address
   - Fallback Access-Point (AP) mode: Connect to RPi's network (IP: 10.0.0.200)

If you encounter connection issues, good troubleshooting steps include connecting a monitor and visualizing the boot sequence. 

## 🌐 Network Behavior

Network management is streamlined by [Robonet](https://github.com/neurobionics/robonet), our custom CLI tool designed to simplify network configuration and management.

Here's a brief overview of its functionality:

- **Primary Connection**: Automatically connects to prioritized WiFi networks.
- **Fallback Mode**: Establishes an access point with a static IP of `10.0.0.200` when no preferred networks are available. Keeping 
- **IP Notification**: Sends an email notification with the device's IP address upon successful connection.

Read more about Robonet [here](https://github.com/neurobionics/robonet).

## Additional Configuration

1. Edit the `motd` file to customize the message of the day. This is displayed when the user logs in.
2. Edit the `packages.Pifile` file to install additional packages, services, and boot sequences.
3. Edit the `ssh.Pifile` file to configure SSH access for users.
4. Edit the `source.Pifile` file to build from a custom source that is not a default raspbian or ubuntu image.

## 🤝 Contributing

All contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 🐞 Debugging

After powercycling the Raspberry Pi, if you have **not** received an email with the IP address after 10 minutes, try the following debugging steps:

### 1. Connect to your Raspberry Pi
1. Check if your RPi is Broadcasting an Access Point
    - Turn on your RPi
    - Scan for available WiFi networks and look for your RPi's SSID
    - Attempt to connect via ssh
    ```
    ssh pi@10.0.0.200
    ```
2. If you cannot ssh into the pi, use a monitor and keyboard to connect
    - Plug a monitor and keyboard into the Raspberry Pi to view and access the terminal directly.

### 2. Power On the Raspberry Pi
Connect the RPi to a power source and allow it to boot fully.
### 3. Check Network Interfaces
Run the following command in the terminal to view all network interfaces:
```
ifconfig
```
- `eth#` refers to Ethernet.
- `wlan#` refers to Wi-Fi.
If `wlan#` is missing or the IP address is not in the expected range, there may be an issue with the wireless network connection, which we will fix in Step 5.

### 4. View Environment Variables
To view the current environment variables:
```
cat /etc/environment
```
If any variables are incorrect, you can modify them by running this command:
```
sudo nano /etc/environment
```
Make any necessary changes, then press `Ctrl + O` to save and `Ctrl + X` to exit.

### 5. Inspect System Network Configurations

Navigate to the network configuration directory
```
cd /etc/NetworkManager/system-connections
```
Most Wi-Fi connection issues can be traced to the `MWireless.nmconnection` file.

To **view** the file:
```
sudo cat MWireless.nmconnection
```
Verify the following:
- `ssid`
- `identity` 
- `password`

To **edit** the file:
```
sudo nano MWireless.nmconnection
```
Make necessary corrections, then save and exit.

> [!NOTE]
> If you are trying to configure the Raspberry Pi as a wireless access point, repeat the steps above to view and edit `RPiAccessPoint.nmconnection`.


### 6. Other Helpful Commands

If you need to manually inspect or edit the interface configuration, follow these steps:
1. Navigate to the Dispatcher scripts directory
   ```
   cd /etc/NetworkManager/dispatcher.d
   ```

2. View the `90-robonet-notify` Script
This script contains logic that handles network events (such as sending an email with the IP address).

   To **view** the file:
   ```
   sudo cat 90-robonet-notify
   ```

   To **edit** the file:
   ```
   sudo nano 90-robonet-notify
   ```
   Make any necessary changes, then press `Ctrl + O` to save and `Ctrl + X` to exit.


## 📜 License

This project is licensed under [Apache 2.0](LICENSE).

## 🐛 Issues

Found a bug or have a suggestion? Please [open an issue](https://github.com/neurobionics/robot-ci/issues).
