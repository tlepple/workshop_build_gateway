## Notes:
*  This was tested and run using Terraform v0.12.17

---

###  Setup GCP Service Account:

1.  Create new service account [here](https://console.cloud.google.com/iam-admin/serviceaccounts)
2.  Select your project name.  `Example: 'gcp-se'`
3.  Click the '+ CREATE SERVICE ACCOUNT' link at top of console.
4.  Give a value to the text box `Service account name`   Example: `tlepple`
5.  Make no changes to the text box `Service account ID`
6.  Give it a description value.  Example `tlepple terraform sa`
7.  Click the `CREATE` button.
8.  In the next screen, do not select a role but do click the `CONTINUE` button.
9.  In this screen, leave everything as the default but do click the `+ CREATE KEY` button.
10. In the pop-up screen, choose a 'key type' of `JSON` and click the `CREATE` button.
11. This will prompt your computer to save a new private key file.  Take note of the file name and location.   Example `gcp-se-2f3b1195299c.json`

*  This new key file will be used later to provision your GCP resources from within `TERRAFORM`

---

#### Update Terraform Varialble Properties in this file.

```
vi /app/workshop_build_gateway/provider/gcp/var-properties.tfvars
```

##### Set these specific properties

```
owner_name = "<replace with your owner name>"
```
---

##### Copy the Key File content into new file in this docker container

1.   On your mac (from a terminal window) run `cat </path/to/keyfile/keyfilename.json>`
2.   Copy the contents of this file to a new file inside of docker container.
     ```
     vi /app/workshop_build_gateway/provider/gcp/keygcp.json
     ```
*  NOTE -- You only have to create the service account one time, regardless of how many times you create/destroy instances with this application.

---

### Build out the GCP Environment:

---

```
# run the build:
cd /app/workshop_build_gateway
. bin/setup.sh gcp
```

---

### Destroy the GCP Environment:

---

```
# destroy the build:
cd /app/workshop_build_gateway
. bin/destroy.sh gcp
```
