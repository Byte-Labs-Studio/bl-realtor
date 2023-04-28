# Svelte-Template
Template for Svelte, TS, Taiwind and FiveM

Pretty cool.

- Theres an Always Listener Event Component to add ReceiveNUI() for anything you always want to listen to and possibly set to stores.
- Has DebugBrowser Component where you can include mock SendNUIMessage events while developing UI inside the browser.
- SendNUI sends action and data to RegisterNUICallback() inside client files.
- SendNUI also has a third parameter for debugReturn for browser development where you can use .then() on.
- Has a visibility Provider which can be toggled with "setVisible" and the data being a boolean.

## WHAT MAKES THIS THE BEST
- YOU CAN RUN LOCAL HOST IN GAME AND THE CLICKS AND ANY SENDNUI WILL TRIGGER CALLBACKS IN SCRIPTS

`npm install`

`npm run dev`

`npm run build`

If you dont know what those does, theres no helping you

### As you can probably tell this is very similar to Project Error's version thats because I used some of their Utils and Visibility Provider but changed them to make them fit my need.
Credit to them.


