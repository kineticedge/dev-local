import os


WTF_CSRF_ENABLED = False

#
# Disable Authorization
#

#AUTH_ROLE_PUBLIC = 'Public'
#AUTH_USER_REGISTRATION_ROLE = 'Public'
#PUBLIC_ROLE_LIKE_GAMMA = True

#PUBLIC_ROLE_LIKE

#Allow for Embedded Javascript within charts that allow it
ENABLE_JAVASCRIPT_CONTROLS = True

#To Avoid hard-cording of personal MAPBOX_API_KEY into the local image, reference from evironment variable.
MAPBOX_API_KEY = os.getenv('MAPBOX_API_KEY', '')
