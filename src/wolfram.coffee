# Description:
#   Allows hubot to answer almost any question by asking Wolfram Alpha
#
# Dependencies:
#   "wolfram": "0.2.2"
#
# Configuration:
#   HUBOT_WOLFRAM_APPID - your AppID
#
# Commands:
#   hubot question <question> - Searches Wolfram Alpha for the answer to the question
#
# Author:
#   dhorrigan

Wolfram = require('wolfram').createClient(process.env.HUBOT_WOLFRAM_APPID)

notSures = process.env.HUBOT_WOLFRAM_NOT_SURE || ''
notSures = (shrug.trim() for shrug in notSures.split('|') when shrug.trim())
notSures = ['Hmm...not sure'] unless notSures.length

module.exports = (robot) ->
  robot.respond /(question|wfa|wolfram) (.*)$/i, (msg) ->
    Wolfram.query msg.match[2], (e, result) ->
      if !result or result.length == 0
        msg.send msg.random notSures
      else if result[1]['subpods'][0]['value'].length > 0
        msg.send result[1]['subpods'][0]['value']
      else if result[1]['subpods'][0]['image'].length > 0
        msg.send result[1]['subpods'][0]['image']
      else
        msg.send msg.random notSure
