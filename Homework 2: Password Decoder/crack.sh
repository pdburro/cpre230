#!/bin/bash

# Target hash and salt extracted from /etc/shadow
target_hash="2UjEq.dUhICPw9zgDVJXcQYQp/9ilLPQt/8Zgu0uwngI5mVvB1eKQG9SnVLjmOOfkB4Jjb5VSAXGXjY4Cf5k90"
salt="xgLS35S6"
password_file="100k-most-used-passwords-NIST.txt"

# Read each password from the file, line by line
while IFS= read -r password; do
    # Generate a SHA-512 hash using OpenSSL with the given salt and password
    generated_hash=$(openssl passwd -6 -salt "$salt" "$password" | cut -d'$' -f4)

    # Compare the generated hash with the target hash
    if [[ "$generated_hash" == "$target_hash" ]]; then
        echo "Password found: $password"  # Print the cracked password
        exit 0  # Exit the script successfully
    fi
done < "$password_file"  # Read from the password file

# If no match was found, print a failure message
echo "Password not found."
