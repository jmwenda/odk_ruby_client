require 'httpclient'
require 'uri'
require 'rexml/document'

class OdkInstance
attr_accessor:url

  def initialize(url)
    @url = URI.parse(url)
  end

  def url
    @url
  end

  def getSubmissions(formname)
    submission_url = URI.join(@url,"view/submissionList")
    params = { :formId => formname }
    submission_url.query = URI.encode_www_form(params)

    http = HTTPClient.new
    httpresults = http.get submission_url

    if httpresults.status == 200
      submission_xml = httpresults.content
      doc = REXML::Document.new(submission_xml)
      all_id_elements = doc.elements.to_a( "//id" ).map { |el| el.text } 
    else
      "Form name not found"
    end
  end

  def uploadForm(form_xml)
    form_post_url = URI.join(@url,"formUpload")
    params = { :form_def_file => File.open(form_xml)}
    doc = REXML::Document.new(File.open(form_xml))
    title = REXML::XPath.first( doc, "//h:title" )

    http = HTTPClient.new
    httpresults = http.post(form_post_url,params)

    if httpresults.status_code == 201
      title.text
    else
      "Form could not be uploaded"
    end
  end

  def addSubmissions(submission_data,media_files)
    submission_post_url = URI.join(@url,"submission")
    params = { :xml_submission_file => File.open(submission_data)}

    http = HTTPClient.new
    httpresults = http.post(submission_post_url,params)
    httpresults.content
  end

end
