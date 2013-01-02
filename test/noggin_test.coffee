assert = require("assert")
helper = require('./test_helper')
noggin = helper.noggin

describe 'noggin', ->
  describe "#setLogLevel()", ->
    it "should replace old level", ->
      noggin.setLogLevel(noggin.ALL)
      assert.equal noggin.ALL, noggin.getLogLevel()

    it "should set a category specific level", ->
      noggin.setLogLevel(noggin.ALL, 'test')
      assert.equal noggin.getLogLevel(), noggin.DEFAULT
      assert.equal noggin.getLogLevel('test'), noggin.ALL

  describe "#forCategory", ->
    it "should pass through category names", ->
      logger = noggin.forCategory("test")
      logger.setLogLevel(noggin.ALL)
      assert.equal logger.getLogLevel(), noggin.ALL
      assert.equal noggin.getLogLevel(), noggin.DEFAULT
