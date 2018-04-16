#. Open PuTTYgen
#. Press "Generate"
#. Move mouse around blank area in window as instructed until key has been generated
#. Select the "Conversions" menu and then "Export OpenSSH key"
#. Press "Yes" at the warning prompt
#. Select "Computer" and then the "U" drive under "Network Location"
#. Type "m2_ssh_key_private" for the file name
#. Press "Save"
#. Leaving the "PuTTY Key Generator" window open, open the PuTTY application
#. Type "m2.smu.edu" into the "Host Name" field
#. Press "Open"
#. Enter your M2 username (first part of your SMU email address)
#. Enter your SMU password
#. At the command prompt type ``echo "`` (note the single double quote at the end)
#. From the "PuTTY Key Generator" window, copy all the text in the "Public key for pasting into OpenSSH authorized_keys file:" section (select all the text, right-click, and select "Copy")
#. Select PuTTY window and right-click at the prompt to paste the copied text
#. At the command prompt type ``" >> ~/.ssh/authorized_keys`` (note the single double quote at the beginning)
#. Press the "Enter (return)" key
#. At the command prompt type ``exit`` to log out of M2
#. Close the "PuTTY Key Generator" window