# Outline

- uuApp Deployment Requirements
- uuApp Local Deployment
- uuApp Initialization
- uuApp Distribution Package Creation
- uuService (only server side) development
- uuWebside (only client side) development
- Adding new library dependency (e.g. plus4u5)
- Debugging in IDE (client side)

# uuApp Deployment Requirements

! Specify application deployment requirements here.

Example: 

- 1x TID
- 1x ASID + sysOwner uuIdentity
- 1x AWID + sysOwner uuIdentity
- 1x OSID (or a MongoDB connection string for local development)

# uuApp Local Deployment


1. Prepare uuApp
2. Install and run client
3. Install and run server
4. Initialize uuAppWorkspace
5. Configure profiles and permissions
6. Test functionality

## 1. Prepare uuApp

1. Rename project uu_appg01_template-uu5-ruby to new project name.
           
   Rename folders uu_appg01_main-client, uu_appg01_main-design, uu_appg01_main-server according project name.

2. Disconnect from git repository
    
    > git remote rm origin
    
    If you have new repository for new project, you can connect it with
    
    > git remote add origin ssh://git@codebase.plus4u.net:9422/<new_repozitory>.git
    
    Verify with
    
    > git remote -v        
     
       origin  ssh://git@codebase.plus4u.net:9422/<new_repozitory>.git (fetch)
       origin  ssh://git@codebase.plus4u.net:9422/<new_repozitory>.git (push)
  

## 2. Install and run client

1. Change project name
    Edit app.json and change values of attributes name, code, description and vendor. For name use (a-z), number (0-9) and chars (_-.). For code use (A-Z), number (0-9) and chars (_-.).

2. Installation
    Open client folder and execute install in command line:

    > cd <your client folder name e.g. uu_appg01_main-client> 
    > npm install

3. Run
    Execute command (in folder *_main-client):

    > npm start

4. In case of developing only client side of application you can open Index in browser - [localhost](http://localhost:1234/)

## 3. Install and run server

1. Mongo DB Installation
    - Download Mongo DB for windows from [MongoDB](https://www.mongodb.com/download-center?jmp=nav#community)
    - Execute downloaded executable and choose complete installation.
    - Run command line. Open "C:\Program Files\MongoDB\Server\3.4\bin" and execute

         > mongod.exe

     ! This installation is only for development only !
    - Recommended client is [RuboMongo](https://robomongo.org) for database administration.
    - Documentation with detailed information is available on [Documentation](https://plus4u.net/ues/sesm?SessFree=ues%253AVPH-BT%253AUAFTEMPLATE)


2. Configure server
    Edit configuration uu_appg01_main-server/development.json and replace <uuIdentity> with your uuIdentity.

3. Make you sure that command "npm run dist" (chapter uuApp Distribution Package Creation) in folder uu_appg01_main-client was called before next step.

4. Run server
    Open directory *-_main-server
    Run ruby run.rb

    > ruby -S run.rb

    The server address can be changed at the line with Rack::Server.start by changing the Host and Port parameters.

# uuApp Initialization

! Obtain authentication token from [showToken VUC](https://oidc.plus4u.net/uu-oidcg01-main/99923616732452117-4f06dafc03cb4c7f8c155aa53f0e86be/showToken). 
  After login it shows token. This key must be used as Authorization header with value "Bearer <token>" in all following calls.

1. Initialize uuAppWorkspace
2. Configure profiles and permissions
3. Test functionality

## 1. Initialize uuAppWorkspace


    Use any rest client and call following calls

    POST http://localhost:6221/uu-demoappg01-main/00000000000000000000000000000000-00000000000000000000000000000001/sys/initAppWorkspace
    Request body:
    {
        "awid": "11111111111111111111111111111111",
        "sysOwner": "<uuIdentity>",
        "licenseOwner" : {
            "organization" : {
                "name" : "Unicorn a.s.",
                "oId" : "154156465465162",
                "web" : "http://www.unicorn.com/"
            },
            "userList" : [
                {
                    "uuIdentity" : "1-1",
                    "name" : "Vladimír Kovář"
                }
            ]
        }
    }
    ! Replace <uuIdentity> with your uuIdentity id.
    Request initialize workspace for demo application.

## 2. Configure profiles and permissions

    Use any rest client and call following call

    POST: http://localhost:6221/uu-demoappg01-main/00000000000000000000000000000000-11111111111111111111111111111111/sys/setProfile
    Request body:
    {
        "code": "Guests",
        "roleUri": "urn:uu:GGALL"
    }
    Request sets all users as Guests for public rights.

## 3. Test functionality

   Open Index in browser - [Home](http://localhost:6221/uu-demoappg01-main/00000000000000000000000000000000-11111111111111111111111111111111/home).

# uuApp Distribution Package Creation

1. Install npm modules if they are not installed

    > cd main/client
    > npm install

2. Build client
    Execute command (in folder main/client):

    > npm run dist

    Performs build into ../server/public/ folder.

2. Package server

    > cd main/server
    > rake uuapps:package


# uuApp Production Deployment

  ! Describe application deployment here.

  Example: 

  1. Deploy uuApp
  2. Share uuApp to asid and awid
  3. Init uuAppWorkspace to uuApp Initialization chapter

## 1. Deploy uuApp

   ! Example only

   In irb console run following uuCommand
  
   - ! Gem uu_c3 must be installed
   - Replace following variables located in <> brackets
      - poolUri - uuUri of the pool where the uuApp will be deployed
      - uuAppBoxUri - uuUri of the uuAppBox where uuApp installation package is located
      - mongoDBConnectionString - Connection string to the primary uuAppObjectStore (Mongo DB)
      - uuSubAppInstanceSysOwnerUuId - uuId of the identity responsible for uuAppWorkspace initialization
      - tid - Id of the territory where the uuApp will be deployed
      - asid - Id of the uuSubAppInstance
  
    require 'uu_c3'
    
    UU::OS::Security::Session.login("passfile")
    
    future = UU::C3::AppDeployment.deploy("<poolUri>",appBoxUri: "<uuAppBoxUri>",
      config: {
        "uuSubAppDataStoreMap":{
          "primary": "<mongoDBConnectionString>"
        },
        "privilegedUserMap": {
          "uuSubAppInstanceSysOwner": "<uuSubAppInstanceSysOwnerUuId>"
        },
        "tid": "<tid>",
        "asid": "<asid>",
    })
    
## 2. Share uuApp to asid and awid

   ! Example only

   In irb console run following uuCommand
   
   - ! The uuApp must be shared for asid and all awids
   - Replace following variables located in <> brackets
      - tid - Id of the territory where the uuApp will be deployed
      - asid - Id of the uuSubAppInstance
      - awid - Id of the uuAppWorkspace
   
    UU::C3::AppDeployment.share("<appDeploymentUri>", 
    territories: [   
      "ues:<tid>-<asid>:<tid>-<asid>",   
      "ues:<tid>-<awid>:<tid>-<awid>"
    ])


# uuService (only server side) development
Note: You can delete this part from application README

1. Delete client directory in main
2. Edit configuration main/server/mappings.json and delete all VUC type entries (value of attribute "type" is "VUC").
3. Start server according to chapter "uuApp Local Execution and Initialization"


# uuWebside (only client side) development
Note: You can delete this part from application README

1. Delete server directory in main
2. Start client according to chapter "uuApp Local Execution and Initialization"


# Adding new library dependency
Note: You can delete this part from application README

1. Edit package.json (in directory main/client) and add new dependency under "dependencies" key under "uuBuildSettings" key.

    - library is available on cdn

          "plus4u5g01": {
            "cdnBaseUri": "https://cdn.plus4u.net/uu-plus4u5g01/1.0.0/"
          },

    - library is linked from development workspace e.g. directly from distribution folder of uu_plus4u5g01 project

          "plus4u5g01": {
            localBaseUri: "../../../uu_plus4u5g01/dist/"
          },

2. Import library in javasript file where it should be used. e.g.

        import * as Plus4U5 from  'plus4u5g01';

3. Use library. e.g.

       render() {
         return (
           <UU5.Layout.Root>
             <Plus4U5.Bricks.HelloWorld/>
           </UU5.Layout.Root>
         )
       }

# Debugging in IDE (client side)
Note: You can delete this part from application README

For RubyMine and other JetBrains IDEs:
1) Install [JetBrains IDE Support](https://chrome.google.com/webstore/detail/jetbrains-ide-support/hmhgeddbohgjknpmjagkdomcpobmllji) Chrome extension.
2) In the WebStorm menu Run select Edit Configurations.... Then click + and select JavaScript Debug.
   Paste http://localhost:1234 into the URL field and save the configuration.

Start the development by running 'npm start', wait till started, then press ^D on macOS or F9 on Windows and Linux
or click the green debug icon to start debugging in RubyMine. Note that debugger might stop on first
JavaScript code right after the Chrome window gets opened - press F9 (Resume Program) to continue.

For Visual Studio Code:
1) Install [Chrome Debugger Extension](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome).
2) Modify or create .vscode/launch.json to include following configuration:
    ```json
    {
      "version": "0.2.0",
      "configurations": [{
        "name": "Chrome (launch app)",
        "type": "chrome",
        "request": "launch",
        "url": "http://localhost:1234/vendor-app-subapp/0-0/",
        "webRoot": "${workspaceRoot}/uu_demoappg01_main-client/src",
        "pathMapping": {
          "/vendor-app-subapp/0-0/public/0.1.0/": plus4u_managerg01_main-server
        },
        "sourceMapPathOverrides": {
          "webpack:///src/*": "${webRoot}/*"
        }
      }]
    }
    ```
    In the configuration above, update 'url', 'webRoot' and 'pathMapping' fields as needed, i.e. update
    '/vendor-app-subapp/0-0/' (URL path; 2 occurrences), 'uu_demoappg01_main' (file system folder prefix, 2x)
    and '0.1.0' (version in pathMapping key, 1x) as needed.

    **Limitation: you have to update the debugger configuration whenever app version changes (key in 'pathMapping')**.

Start the development by running 'npm start', wait till started, press F5 to start VS Code debugging. Note that VS Code
might miss some breakpoints right after Chrome window gets opened - reloading the page fixes it.