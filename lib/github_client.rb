class GithubClient
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize
    @client_id = ENV['GH_BASIC_CLIENT_ID']
    @client_secret = ENV['GH_BASIC_SECRET_ID']
  end

  def get_auth_token(code)
    self.class.post('https://github.com/login/oauth/access_token',
                    body: {client_id: @client_id,
                           client_secret: @client_secret,
                           code: code},
                    headers: {Accept: 'application/json'})
  end

  def get_user(access_token)
    self.class.get('/user',
                   headers: {'User-Agent': 'Httparty',
                             Authorization: "token #{access_token}"})
  end

  def get_user_emails(access_token)
    self.class.get('/user/emails',
                   headers: {'User-Agent': 'Httparty',
                             Authorization: "token #{access_token}"})
  end

  def get_contents(access_token, owner, repo, path)
    self.class.get("/repos/#{owner}/#{repo}/contents/#{path}",
                   headers: get_headers(access_token))
  end

  def update_content(access_token, params)
    self.class.put("/repos/#{params[:owner]}/#{params[:repo]}/contents/#{params[:path]}",
                   body: {  message: params[:message],
                            commiter: {  name: params[:name],
                                         email: params[:email] },
                            content: params[:content],
                            sha: params[:sha] }.to_json,
                   headers: get_headers(access_token))
  end

  def get_headers(access_token)
    {'User-Agent': 'Httparty',
     Authorization: "token #{access_token}",
     Accept: 'application/json'}
  end
end