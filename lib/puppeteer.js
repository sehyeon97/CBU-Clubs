const puppeteer = require('puppeteer');
const fs = require('fs');

(async () => {
    try {
        // Open window
        const browser = await puppeteer.launch({
            "headless": false,
            "slow-mo": 50,
            "ignoreHTTPSErrors": true,
            "defaultViewport": null
        });
        const page = await browser.newPage();
        await page.goto("https://calbaptist.edu/life-at-cbu/community-life/clubs-and-organizations");
        await page.waitForSelector('.page-main-content');
        const content = await page.$('.page-main-content');

        // Get data
        const ps = await page.evaluate(el => {
            return Array.from(el.querySelectorAll('p')).map(p => p.textContent);
            }, content);
        const h2s = await page.evaluate(el2 => {
            return Array.from(el2.querySelectorAll('h2')).map(h2 => h2.textContent);
            }, content);

        // Convert text to json string
        let json = "[";
        let pCount = 8;
        for (const h2 of h2s) {

            json += "{\"name\": \"" + h2 + "\", \n";
            json += "\"description\": \"" + ps[pCount] + "\", \n";
            if (ps[pCount + 1] === "President - Jose MendozaAdvisor - Mario Oyanader") {
                console.log("I did something");
                json += "\"president\": \"" + "Jose Mendoza" + "\", \n";
                json += "\"advisor\": \"" + "Mario Oyanader" + "\"\n}, \n";
                pCount -= 1;
            } else if (ps[pCount + 1] === "President - Adam Kneale") {
                console.log("I did something else");
                json += "\"president\": \"" + "Adam Kneale" + "\", \n";
                json += "\"advisor\": \"" + "TBD" + "\"\n}, \n";
                pCount -= 1;
            } else {
                json += "\"president\": \"" + ps[pCount + 1] + "\", \n";
                json += "\"advisor\": \"" + ps[pCount + 2] + "\"\n}, \n";
            }
            pCount += 3;
        }
        json = json.slice(0, -3);
        json += "\n]"

        // Remove parts of text
        json = json.replace(/\s+/g, ' ');
        json = json.replace(/President - /g, '');
        json = json.replace(/Advisor - /g, '');
        const jsonParse = JSON.parse(json.replace(/\r?\n|\r/g, ''));
        const jsonString = JSON.stringify(jsonParse, null, 2);

        // Save string to .json file
        fs.writeFile("data/output.json", jsonString, (err) => {
            if (err) {
                console.error("Error writing file:", err);
            } else {
                console.log("JSON file has been saved.");
            }
        });

        await browser.close();
    } catch (e) {
        console.log('error', e);
    }
})();