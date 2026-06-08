#!/bin/bash
# Detect Homebrew prefix (Intel vs Apple Silicon)
if [ -d "/opt/homebrew" ]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi
export PATH="$BREW_PREFIX/bin:$PATH"
stop_services() {
    echo ""
    echo "Stopping services..."
    brew services stop mysql
    brew services stop php
    kill $PHPMYADMIN_PID 2>/dev/null
    echo "Done."
}
trap stop_services EXIT
echo "Starting MySQL..."
brew services start mysql
echo "Starting PHP..."
brew services start php
echo "Starting phpMyAdmin on http://localhost:8081 ..."
cd "$BREW_PREFIX/share/phpmyadmin" && php -S localhost:8081 &
PHPMYADMIN_PID=$!
echo ""
echo "Services running. Open http://localhost:8081 in your browser."
echo "Press Ctrl+C to stop manually."
sleep 1
open http://localhost:8081
while true; do
    sleep 1
done