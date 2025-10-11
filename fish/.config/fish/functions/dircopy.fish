function dircopy
    set -l dir (or $argv[1] .)
    set -l index 1

    # Start XML
    echo "<documents>"

    # Iterate over files from rg --files, excluding hidden files
    rg --files $dir | while read -l file
        echo "  <document index=\"$index\">"
        echo "    <source>$file</source>"
        echo "    <document_content>"
        
        # Read each line from the file
        while read -l line
            if test -n "$line"
                printf "      %s\n" $line
            else
                echo "      "
            end
        end < $file

        echo "    </document_content>"
        echo "  </document>"
        set index (math $index + 1)
    end

    # End XML
    echo "</documents>"
end
