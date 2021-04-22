function pass2org --description "Export pass to Org mode"
    # Create a list containing every password file managed by pass.
    set pass_files (find "$PASSWORD_STORE_DIR" -name '*.gpg' | sort)

    echo "#+TITLE: Passwords"

    for file in $pass_files
        # Extract the password name embedded in password file name.
        set pass_name (echo $file | sed -e "s!^$PASSWORD_STORE_DIR/!!" -e 's!\.gpg$!!')

        # Create an Org mode entry for the password.
        echo
        echo "* $pass_name"

        if echo $pass_name | grep -q -e '/Key$' -e '/Private Key$' -e '/Public Key$' -e '/Revocation Certificate$' -
            # Encryption keys are treated as a special case.
            echo
            echo "#+BEGIN_SRC"
            pass $pass_name
            echo "#+END_SRC"
        else
            # Extract the password and any related
            # information. Related password information is stored in
            # the form of key-value pairs.
            set pass_info (pass "$pass_name")

            # In Org mode, store passwords in property drawers.
            echo ":PROPERTIES:"

            # Add the password.
            echo ":Password: $pass_info[1]"
            set -e pass_info[1]

            # Add any related information.
            for line in $pass_info
                set pair (echo "$line" | string split -m1 : | string trim)

                echo -n ":"
                echo -n "$pair[1]" | sed 's!\s!_!g'
                echo -n ": "
                echo "$pair[2]"
            end

            echo ":END:"
        end
    end
end
