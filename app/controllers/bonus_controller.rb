require 'github_client'
require 'nokogiri'
require 'open-uri'
require 'base64'

class BonusController < ApplicationController

  def index
    redirect_to root_path if session['access_token'].nil?

    @content = Base64.decode64 content_info['content']
    @content_modified = add_snippets @content
  end

  def bonus_modified_page
    content = Base64.decode64 content_info['content']
    render html: add_snippets(content).html_safe, layout: false
  end

  def update_repo
    github_client = GithubClient.new
    response = content_info
    content = Base64.decode64 response['content']
    if params[:add]
      content_modified = Base64.encode64(add_snippets(content))
      @result = github_client.update_content(session['access_token'],
                                             owner: 'CGN',
                                             repo: 'simple-html-page',
                                             path: 'index.html',
                                             message: 'Added snippets',
                                             name: 'Nurlan',
                                             email: 'cg.nurlan@gmail.com',
                                             content: content_modified,
                                             sha: response['sha']
      )
    else
      content_modified = Base64.encode64(remove_snippets(content))
      @result = github_client.update_content(session['access_token'],
                                             owner: 'CGN',
                                             repo: 'simple-html-page',
                                             path: 'index.html',
                                             message: 'Snippets removed',
                                             name: 'Nurlan',
                                             email: 'cg.nurlan@gmail.com',
                                             content: content_modified,
                                             sha: response['sha']
      )
    end
    puts @result
    redirect_to bonus_path
  end

  private

  def content_info
    GithubClient.new.get_contents(session['access_token'],
                                  'CGN',
                                  'simple-html-page',
                                  'index.html')
  end

  def add_snippets(html)
    doc = Nokogiri::HTML(html)
    head = doc.at_css 'head'
    body = doc.at_css 'body'

    if doc.at_css('script').nil?
      head.add_child '<script src="https://www.powr.io/powr.js"></script>'
    end

    if doc.at_css('div.powr-form-builder').nil?
      body.add_child '<div class="powr-form-builder" id="unique-uuid"></div>'
    end

    doc.to_s
  end

  def remove_snippets(html)
    doc = Nokogiri::HTML(html)
    head = doc.at_css 'head'
    body = doc.at_css 'body'

    head.inner_html = '<title>Simple html page</title>'
    body.inner_html = ''

    doc.to_s
  end
end