# import shutil
# import sys

# APP_VERSION = sys.argv[1]

# # Backup the original chart.yaml
# shutil.copy('petclinic/Chart.yaml', 'petclinic/Chart_bk.yaml')

# def chartModif(chart_version):
#     # Read the content of the file
#     with open("petclinic/Chart.yaml", 'r') as f:
#         content = f.readlines()

#     # Modify the content
#     with open("petclinic/Chart.yaml", 'w') as f1:
#         for line in content:
#             if 'version:' in line:
#                 f1.write(f'version: {chart_version}\n')  # Update version
#             elif 'appVersion:' in line:
#                 f1.write(f'appVersion: {chart_version}\n')
#             else:
#                 f1.write(line)  # Keep other lines unchanged

# # Call function with a new version
# chartModif('APP_VERSION')

import shutil
import sys

# Ensure the script is executed with a version argument
if len(sys.argv) < 2:
    print("Usage: python script.py <app_version>")
    sys.exit(1)

APP_VERSION = sys.argv[1]

# Backup the original Chart.yaml
shutil.copy('petclinic/Chart.yaml', 'petclinic/Chart_bk.yaml')

def chartModif(chart_version):
    # Read the content of the file
    with open("petclinic/Chart.yaml", 'r') as f:
        content = f.readlines()

    # Modify the content
    with open("petclinic/Chart.yaml", 'w') as f1:
        for line in content:
            if 'version:' in line:
                f1.write(f'version: {chart_version}\n')  # Update version
            elif 'appVersion:' in line:
                f1.write(f'appVersion: {chart_version}\n')  # Update appVersion
            else:
                f1.write(line)  # Keep other lines unchanged

# Call function with the correct version
chartModif(APP_VERSION)
