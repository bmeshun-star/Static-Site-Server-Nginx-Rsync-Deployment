#!/bin/bash
SERVER="ec2-user@18.170.68.229"
REMOTE_PATH="/var/www/portfolio"
KEY_PATH="$HOME/.ssh/MyKeyPair.pem"

echo "🚀 Testing what will be copied..."
rsync -avzn --no-perms --delete \
  -e "ssh -i $KEY_PATH -o IdentitiesOnly=yes -o WarnWeakCrypto=no" \
  ./ $SERVER:$REMOTE_PATH/

read -p "✅ Looks good? Press Enter to deploy..."

echo "🚀 Deploying files..."
rsync -avz --no-perms --delete \
  -e "ssh -i $KEY_PATH -o IdentitiesOnly=yes -o WarnWeakCrypto=no" \
  ./ $SERVER:$REMOTE_PATH/

echo "✅ Done! Visit: http://18.170.68.229"