# Step 1
## email with 2 step verification

# Step 2
## create an app for sending message with gmail
https://myaccount.google.com/security

# Step 3
## generate app password

# Step 4
## setup some variables

EMAIL_BACKEND='django.core.mail.backends.smtp.EmailBackend'
EMAIL_HOST = 'smtp.gmail.com'
EMAIL_USE_TLS = True
EMAIL_PORT = 587
EMAIL_HOST_USER = config("EMAIL_HOST_USER") # sender email
EMAIL_HOST_PASSWORD = config("EMAIL_HOST_PASSWORD") #password
ACCOUNT_EMAIL_VERIFICATION = 'mandatory'
ACCOUNT_LOGIN_ON_EMAIL_CONFIRMATION=True


# step 5
## python.decouple 
from decouple import config

# step 6 setup .env variable
EMAIL
PASSWORD

# step 7 setup endpoint
from dj_rest_auth.registration.views import VerifyEmailView
path('dj-rest-auth/account-confirm-email/', VerifyEmailView.as_view(), name='account_email_verification_sent')

# step 8 write an email
DIRS=[os.path.join(BASE_DIR,'templates')]
templates/account/email/email_confirmation_message.txt
templates/account/email/email_confirmation_subject.txt