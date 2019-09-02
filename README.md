# Backolo

## Intro

A simple bash script for Linux that creates a backup of / (root) and saves it as a tar.gz file at /backolo-backups.
Bacolo is using tar to archive your files and gzip to compress the size.
A great script for example servers.

Updates, fixes and new features will be ever now and then.

![backolo-screenshot](https://cloud.codeiolo.org/s/MmF9cdXMSKSdL3q/preview)

## Install

Download the [backolo.sh](https://github.com/codeiolo/backolo) file or clone the project from Github

```
git clone https://github.com/luxwarp/backolo.git
```

## Usage

Run the backolo.sh file in terminal

```
sudo ./path/to/backolo.sh
```

Yes sudo is necessary because backolo is creating folders and files in your root directory (/)

## Result

When you run backolo without changing any code it will do a complete backup of your / (root) folder.
It will save this backup file inside a folder named backolo-backups at your root folder.
When backolo is running you will also get 2 different log files. One is backolo-run.log and it's created at the same folder as you run backolo script from. The second log file is your backup log file which contains information about all files and folders that is backed up. This file is located with your backup files at /backolo-backups folder in root.

**It does not backup any mounted partitions**

## License

ISC [Mikael Luxwarp Carlsson](https://codeiolo.org)

## Note

Feel free to contribute the way you want.
