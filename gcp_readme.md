---
## Notes:
*  This was tested and run using Terraform v0.12.17

---
###  Setup GCP Service Account:

1.  Create new service account [here](https://console.cloud.google.com/iam-admin/serviceaccounts)
2.  Select your project name.  `Example: 'gcp-se'`
3.  Click the '+ CREATE SERVICE ACCOUNT' link at top of console.
4.  Give a value to the text box `Service account name`.   Example: `tlepple`
5.  Make no changes to the text box `Service account ID`
6.  Give a description.  Example `tlepple terraform sa`
7.  Click the `CREATE` button.
8.  In the next screen do not select a role but do click the `CONTINUE` button.
9.  In this screen, leave everything as the default but do click the `+ CREATE KEY` button.
10. In the pop-up screen choose a 'key type' of `JSON` and click the `CREATE` button.
11. This will prompt your computer to save a new private key file.  Take note of the file name and location.   Example `gcp-se-2f3b1195299c.json`

*  This new key file will be used later to provision your GCP resources from within `TERRAFORM`
