1. Enable `#enable-devtools-experiments` flag in `chrome://flags` section.
2. Open Chorme Devtools and check `Settings > Experiments > Allow extensions to load custom stylesheets`.
3. Create the following four files in a dedicated folder.

    3.1. `devtools.html`
	
	```html
	<html>
	<head></head>
	<body><script src="devtools.js"></script></body>
	</html>
	```
	
	3.2. `devtools.js`
	
	```javascript
	var x = new XMLHttpRequest();
	x.open('GET', 'style.css');
	x.onload = function() {
	    chrome.devtools.panels.applyStyleSheet(x.responseText);
	};
	x.send();
	```
	
	3.3. `style.css`
	
	```css
    body.platform-windows,
    body.platform-linux,
    :host-context(.platform-windows),
    :host-context(.platform-linux) {
        --monospace-font-size: 12px !important;
        --monospace-font-family: "Consolas", monospace !important;
        --source-code-font-size: 12px !important;
        --source-code-font-family: "Consolas", monospace !important;
    }

    .monospace {
        font-size: var(--monospace-font-size);
        font-family: var(--monospace-font-family);
    }

    .source-code {
        font-size: var(--source-code-font-size);
        font-family: var(--source-code-font-family);
    }
	```
	
	3.4. `manifest.json`
	
	```javascript
    {
        "name": "Custom Chrome Devtools Theme",
        "version": "1.0.0",
        "description": "A customized theme for Chrome Devtools.",
        "devtools_page": "devtools.html",
        "manifest_version": 3
	}
	```

4. Open Chrome Extensions tab, click `Load expanded extension` and point to the folder containing all four files.
