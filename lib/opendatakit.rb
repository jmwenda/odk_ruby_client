require 'httpclient'
require 'uri'
require 'rexml/document'
class OdkInstance
attr_accessor:url
  def initialize(url)
    @url = URI.parse(url)
  end
  def url
    puts @url
  end
  def getSubmissions(formname)
    submission_url = URI.join(@url,"/view/submissionList")
    params = { :formId => formname}
    submission_url.query = URI.encode_www_form( params )
    http = HTTPClient.new
    httpresults = http.get submission_url
    if httpresults.status == 404
      puts "Form name not found"
      exit
    end
    submission_xml = httpresults.content
    doc = REXML::Document.new(submission_xml)
    submissions = []
    all_upc_strings = doc.elements.to_a("idChunk/idList")
    all_id_elements = doc.elements.to_a( "//id" )
    #doc.elements.each("idChunk/idList") { |element| submissions.push(element.elements["id"].text) }
    puts all_id_elements 
  end
  def uploadForm(form_xml)
    form_post_url = URI.join(@url,"/formUpload")
    params = { :form_def_file => File.open(form_xml)}
    doc = REXML::Document.new(File.open(form_xml))
    title = REXML::XPath.first( doc, "//h:title" )
    http = HTTPClient.new
    httpresults = http.post(form_post_url,params)
    puts title.text
  end
end
