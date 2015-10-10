
DEFAULT_URL = "https://auth.robokassa.ru/Merchant/Index.aspx"
TEST_URL = "http://test.robokassa.ru/Index.aspx"

crypto = require "crypto"
url = require "url"

class Robokassa

  ###*
  @method constructor
  @param config {Object} configuration object
  @param config.login {String} login of technically Robokassa config
  @param config.password1 {String} password1 of technically Robokassa config
  @param config.password2 {String} password2 of technically Robokassa config
  @param config.url [String] url of Robokassa server (may be test, default is `https://auth.robokassa.ru/Merchant/Index.aspx`)
  @param config.test [Boolean] set test url of Robokassa (test url is `http://test.robokassa.ru/Index.aspx`)
  ###
  constructor: ({@login, @password1, @password2, @url, test})->

    ###*
    login of technically Robokassa config
    @property login
    @type string
    ###

    ###*
    password1 of technically Robokassa config
    @property password1
    @type string
    ###

    ###*
    password2 of technically Robokassa config
    @property password2
    @type string
    ###
    test ?= false

    ###*
    url of Robokassa server (may be test, default is `https://auth.robokassa.ru/Merchant/Index.aspx`)
    @property url
    @type string
    ###
    @url ?= if test then TEST_URL else DEFAULT_URL


  createUrl: ({id, summ, description})->

    urlObject = url.parse @url

    urlObject.query = {
      MrchLogin: @login
      OutSum: summ
      InvId: id
      Desc: description
      SignatureValue: @md5 "#{@login}:#{summ}:#{id}:#{@password1}"
    }

    return url.format urlObject

  checkPaymentParams: ({OutSum, InvId, SignatureValue})->

    @md5("#{OutSum}:#{InvId}:#{@password2}").toUpperCase() is SignatureValue.toUpperCase()

  md5: (string)->

    crypto.createHash("md5").update(string).digest("hex")




module.exports = Robokassa