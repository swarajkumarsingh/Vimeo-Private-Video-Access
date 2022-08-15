const http = require("https");

const options = {
  "method": "GET",
  "hostname": "api.vimeo.com",
  "port": null,
  "path": "/videos/737153523",
  "headers": {
    "Authorization": "bearer 67ec653866dd423f9eaa17cb9122ab0e"
  }
};

const req = http.request(options, function (res) {
  const chunks = [];

  res.on("data", function (chunk) {
    chunks.push(chunk);
  });

  res.on("end", function () {
    const body = Buffer.concat(chunks);
    console.log(body.toString());
  });
});

req.end();