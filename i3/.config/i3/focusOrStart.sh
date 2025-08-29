    #!/bin/sh
    
count=`ps aux | grep -c $1 | grep -v grep`
echo $count
if [ $count -eq 0 ]; then
    $1
else
    if ! i3-msg "[class=$1] focus"; then
        i3-msg "[instance=$1] focus"
    fi
fi
