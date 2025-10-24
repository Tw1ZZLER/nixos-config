function runsilk
    cd /home/tw1zzler/Silk
    python -m server &
    cd /home/tw1zzler/Silk/GUI
    python -m http.server 8000 &
end
