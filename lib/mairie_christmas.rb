#coding: utf-8
#récupère les adresses e-mails des mairies du Val d'Oise.
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall)

  page_mairie = Nokogiri::HTML(open("http://www.annuaire-des-mairies.com/95/#{townhall}.html"))

  #puts email = page_mairie.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text

  # récupartion du text du td dont  la chaine de caractères contient un arobase
  email = page_mairie.xpath('//td[contains(text(),"@")]').text
  return email
end

# récupère l'url de la fiche des mairies à partir de la région
def get_townhall_urls(region)
  #page_mairies = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
  page_mairies = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/#{region}.html"))

  #récupère les <a> dont l'attribut de la classe contient "lientxt" au apparait le nom de la mairies
  mairies = page_mairies.xpath('//a[contains(@class,"lientxt")]')


  mairies = mairies.map{|m|
    #recupère le contenu textuel des <a>, met tout en minuscule, remplace les espaces par des traits d'union
    m.text.downcase.gsub(" ","-") }

  emails=[]
  #recupère l'email de chaque mairie
  mairies.each do |mairie|
    #puts get_townhall_email(mairie)
    emails << get_townhall_email(mairie)
    puts "#{emails.length} emails récupérés"
  end

  #puts emails
  return emails
end

 puts get_townhall_urls("val-d-oise")
