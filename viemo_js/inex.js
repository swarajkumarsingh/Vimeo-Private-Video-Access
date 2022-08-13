const axios = require('axios');

async function kuch() {
    res = await axios.get("https://vod-progressive.akamaized.net/exp=1660247984~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F1194%2F29%2F730972653%2F3387012692.mp4~hmac=2a66acd1154c83d1b0f3d0ef9fadaf595dcdda93dee01bbb51705d7788c3be2c/vimeo-prod-skyfire-std-us/01/1194/29/730972653/3387012692.mp4")
    console.log(res);
}

kuch()