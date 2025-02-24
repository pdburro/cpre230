from passlib.hash import sha512_crypt

# Given hash from /etc/shadow
target_hash = "2UjEq.dUhICPw9zgDVJXcQYQp/9ilLPQt/8Zgu0uwngI5mVvB1eKQG9SnVLjmOOfkB4Jjb5VSAXGXjY4Cf5k90"
salt = "xgLS35S6"

# Load and read 100k-most-used-passwords-NIST.txt file given in homework description
with open("100k-most-used-passwords-NIST.txt", "r", encoding="utf-8") as f:
    for password in f:
        password = password.strip()
        
        # Generate hash using salt and 5000 rounds
        generated_hash = sha512_crypt.hash(password, salt=salt, rounds=5000)
        
        if generated_hash.split("$")[-1] == target_hash:
            print(f"Password found: {password}")
            break
    else:
        print("Password not found.")
