# Description
#   nyaa.net 搜索机器人脚本
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   nyaa search <name> <page> <size> - 搜索nyaa.net
#   sukebei search <name> <page> <size> - 搜索sukebei.nyaa.net
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   神楽坂喵

module.exports = (robot) ->

  robot.hear /nyaa search (.*) (.*) (.*)/, (res) ->
    robot.http("https://nyaa.net/api/search?q=#{res.match[1]}&page=#{res.match[2]}&limit=#{res.match[3]}&sort=3&order=false")
      .get() (err, resp, body) ->
        if err
          res.send "got problem when request search: #{err}"
          robot.emit 'error', err, resp
          return
        data = null
        try
          data = JSON.parse body
        catch error
          res.send "got JSON parse error #{error}"
          return
        res.send "展示搜索到的`#{data.queryRecordCount}`个结果,共有`#{data.totalRecordCount}`个结果。"
        res.send "名称:`#{torrent.name}`\n描述:`#{torrent.description}`\n文件大小:`#{humanFileSize(torrent.filesize)}`\n上传日期:`#{torrent.date}`\n磁力链接:`#{torrent.magnet}`\n种子文件:`#{torrent.torrent}`" for torrent in data.torrents
        return


  robot.hear /sukebei search (.*) (.*) (.*)/, (res) ->
    robot.http("https://sukebei.nyaa.net/api/search?q=#{res.match[1]}&page=#{res.match[2]}&limit=#{res.match[3]}&sort=3&order=false")
      .get() (err, resp, body) ->
        if err
          res.send "got problem when request search: #{err}"
          robot.emit 'error', err, resp
          return
        data = null
        try
          data = JSON.parse body
        catch error
          res.send "got JSON parse error #{error}"
          return
        res.send "展示搜索到的`#{data.queryRecordCount}`个结果,共有`#{data.totalRecordCount}`个结果。"
        res.send "名称:`#{torrent.name}`\n描述:`#{torrent.description}`\n文件大小:`#{humanFileSize(torrent.filesize)}`\n上传日期:`#{torrent.date}`\n磁力链接:`#{torrent.magnet}`\n种子文件:`#{torrent.torrent}`" for torrent in data.torrents
        return

`
function humanFileSize(bytes) {
    var thresh = 1024;
    if(Math.abs(bytes) < thresh) {
        return bytes + ' B';
    }
    var units = ['KiB','MiB','GiB','TiB','PiB','EiB','ZiB','YiB'];
    var u = -1;
    do {
        bytes /= thresh;
        ++u;
    } while(Math.abs(bytes) >= thresh && u < units.length - 1);
    return bytes.toFixed(4)+' '+units[u];
}
`