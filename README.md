![](https://img.shields.io/badge/Microverse-blueviolet)

# Best ebay deals

> This project is a scraper for products on [ebay](https://ebay.com), with auction ending in less than 24hrs

![screenshot](./app_screenshot.png)

The project uses open-uri to open http request to a customized ebay web address and creats a Nokogiri object based on the HTML parsed from the address.
- also fetches more HTML by updating the page number query string.
- once done with fetching, serves a search result page with ebay products filtered to have auction ending in less than 24hrs.

## Built With

- Ruby
- Sinatra
- HTML5
- Sass
- bootstrap

## Live Demo

[Live Demo Link](https://bayhunt.herokuapp.com/)


## Authors

👤 **Binyam Hailemeskel**

- GitHub: [@bini-i](https://github.com/bini-i)
- Twitter: [@binyamshewa](https://twitter.com/binyamshewa)
- LinkedIn: [LinkedIn](https://www.linkedin.com/in/bini-i/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- ebay
- Nokogiri

## 📝 License

This project is [MIT](./LICENSE) licensed.
