#!/usr/bin/env bash
set -e

g='\033[0;32m'
y='\033[0;33m'
n='\033[0m'

echo
echo -e "   __   __   __   ___ "
echo -e "  /  \` /  \ |  \ |__  "
echo -e "  \__, \__/ |__/ |___ "
echo -e "   __       ___       "
echo -e "  |__)  /\   |   |__|  "
echo -e "  |    /--\  |   |  |  "
echo -e "        __   __   ___  "
echo -e "  ${g}\|/  ${n}/  \ |__) / _   "
echo -e "  ${g}/|\  ${n}\__/ |  \ \__/  "
echo
echo -e "Welcome to the ${g}Threat Hunt Lab${n} environment!"
echo

INIT_SENTINEL="/opt/splunk/var/.lab-initialized"

echo "Keep this terminal open while you work — closing it stops Splunk."
echo "Splunk takes 60–90 seconds to start."
echo

# Start Splunk (suppress verbose startup output)
echo "Starting Splunk..."
/opt/splunk/bin/splunk start --accept-license --answer-yes --no-prompt > /dev/null 2>&1

# Wait for Splunk to be ready.
# Free license is pre-configured in the image via server.conf, so no runtime
# license activation or restart is needed on any run.
echo -n "Waiting for Splunk to initialize"
until /opt/splunk/bin/splunk status 2>/dev/null | grep -q 'is running'; do
    printf '.'
    sleep 3
done
echo


if [ ! -f "$INIT_SENTINEL" ]; then
    echo
    echo "Indexing lab data..."
    # Free license is pre-configured in the image (server.conf) — no runtime activation needed.


    # /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/test.csv -index main -sourcetype csv -auth 'admin:codepath'
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/TrafficLabelling/Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/TrafficLabelling/Friday-WorkingHours-Afternoon-PortScan.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/TrafficLabelling/Friday-WorkingHours-Morning.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath' 
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/TrafficLabelling/Monday-WorkingHours.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/TrafficLabelling/Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/TrafficLabelling/Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/TrafficLabelling/Tuesday-WorkingHours.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/TrafficLabelling/Wednesday-workingHours.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/MachineLearningCVE/Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/MachineLearningCVE/Friday-WorkingHours-Afternoon-PortScan.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'    
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/MachineLearningCVE/Friday-WorkingHours-Morning.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/MachineLearningCVE/Monday-WorkingHours.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/MachineLearningCVE/Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/MachineLearningCVE/Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/MachineLearningCVE/Tuesday-WorkingHours.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    sleep 10
    /opt/splunk/bin/splunk add oneshot /opt/splunk-data-capstone/MachineLearningCVE/Wednesday-workingHours.pcap_ISCX.csv -index main -sourcetype csv -auth 'admin:codepath'
    touch "$INIT_SENTINEL"
fi


echo
echo -e "${g}============================================${n}"
echo -e "${g}  Splunk is ready!${n}"
echo
echo -e "  Open your browser and go to:"
echo -e "    ${g}http://localhost:8000${n}"
echo
echo -e "  Log in with:"
echo -e "    Username: ${g}admin${n}"
echo -e "    Password: ${g}codepath${n}"
echo -e "${g}============================================${n}"
echo
echo "Press Ctrl+C to stop Splunk and exit."
echo

# Keep container alive
sleep infinity
