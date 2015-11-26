# Description:
#   Gets the current picnic menu
#
# Commands:
#   hubot picnic - Get today's picnic menu

api_key = process.env.HUBOT_TUMBLR_API_KEY
url = "http://api.tumblr.com/v2/blog/picniccoffee.tumblr.com/posts/text?api_key=#{api_key}"

module.exports = (robot) ->
  robot.respond /picnic/i, (msg) ->
    msg.http(url).get() (err, res, body) ->
      data = JSON.parse(body)
      post = data.response.posts[0]
      msg.send(post.title)

      text = post.body
      text = text.replace(/<\/?p>/g, "")

      items = text.split(/<strong>/)
      for item in items
        continue if !item
        [title, info] = item.split('</strong>')
        info = info.replace(/<br\/?>/g, '')
        msg.send("#{title} - #{info}")

