# coding: utf-8
#conding: utf-8
#pogramme qui récupère le cours de toutes les cryptomonnaies et les enregistre bien proprement dans un array de hashs.



require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
puts page.class



currencies =  page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]')

values = page.xpath('//*[@id="__next"]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]')

#convertir l'objet Nodeset issue en un array de string sans redondance on ajoute .uniq
currencies_array = currencies.map{|c| c.text }
#puts curr_array
values_array = values.map{|v| v.text }

#suppimer le $ initial
values_array.map!{|v| v[1..-1] }

#convertir en float
values_array.map!{|v| v.to_f }



crypto_array =[]

def arrayfy(arr1, arr2)
#convertir les 2 arrays (de taille égale) en 1 array de hash par pair ayant le meme index
  array_of_hashes_of_2_el =arr1.each_with_index.map{|element,index| {element => arr2[index]}}
  return array_of_hashes_of_2_el
end

crypto_array=arrayfy(currencies_array, values_array)


puts crypto_array
