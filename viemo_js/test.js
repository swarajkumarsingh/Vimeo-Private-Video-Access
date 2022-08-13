let Vimeo = require('vimeo').Vimeo;
  let client = new Vimeo("d08b2909bd70a655fdcbd2614d97d422d8592a11", "nUgnquWKeN0WjwDsfCmVXpp4/Ij6LlM0/ns+U+Z/5FmTQG2sEafCWai2VDumVVBrNFWNSvZUnCcyg77mNsHY8pKqJET1Dtbt8/BcgNKp/2LqdKBm4Sgvv6Ml/YmvxlHM", "67ec653866dd423f9eaa17cb9122ab0e");

  client.request({
    method: 'GET',
    path: '/tutorial'
  }, function (error, body, status_code, headers) {
    if (error) {
      console.log(error);
    }

    console.log(body);
  })

  let file_name = "./video.mp4";
client.upload(
  file_name,
  {
    'name': 'Untitled',
    'description': 'The description goes here.'
  },
  function (uri) {
    console.log('Your video URI is: ' + uri);

    client.request(uri + '?fields=link', function (error, body, statusCode, headers) {
  if (error) {
    console.log('There was an error making the request.')
    console.log('Server reported: ' + error)
    return
  }

  console.log('Your video link is: ' + body.link)
})
  },
  function (bytes_uploaded, bytes_total) {
    var percentage = (bytes_uploaded / bytes_total * 100).toFixed(2)
    console.log(bytes_uploaded, bytes_total, percentage + '%')
  },
  function (error) {
    console.log('Failed because: ' + error)
  }
)

