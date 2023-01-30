# Proxmox web bruteforce
This program can brute force the web authentication page of Proxmox PVE

    WARNING DISCLAMER ! 
    This program has been written for educational purposes. It must be used within a legal framework and on controlled infrastructures.
    All liability is disclaimed for any use that does not comply with the terms of use of this program.

## Build
Clone the repos and build `run.nim`
```shell
git clone https://github.com/lil-doudou/Proxmox_web_bruteforce.git
cd Proxmox_web_bruteforce
nim compile -d:ssl run.nim
```

## Usage
Run the program with parameter
```shell
./run -p <password_list> -t <target>
```

## How it works
The program send a web request to the Proxmox VE api. The default Proxmox VE user is `root` and it's the same account of the `root` user of the host. By default, the realm is `pam` so if you find the password of the `root` user on Proxmox, you find the `root` password of the host.

The program check the return byte lenght of the failure authentication. If the return message are > 77, the authentication are succeseful. 

## TO DO
- [ ] Thread the program
- [ ] Check the time to respond