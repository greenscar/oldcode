#!/usr/bin/python
# -*- coding: utf-8 -*-
import MySQLdb
import datetime, xmlrpclib
import sys
import string
wp_url = "http://www.pyroglyphics.com/wordpress/xmlrpc.php"
wp_username = "aubri"
wp_password = "z00l00"
wp_blogid = ""

html_escape_table = {
   "&": "&amp;",
   '"': "&quot;",
   "'": "&apos;",
   ">": "&gt;",
   "<": "&lt;",
   "Õ": "&apos;",
   }

def html_escape(text):
  """Produce entities within text."""
  return "".join(html_escape_table.get(c,c) for c in text)
   
db = MySQLdb.connect(host="localhost", # your host, usually localhost
                     user="aubri", # your username
                      passwd="z00l00", # your password
                      db="oohaheats") # name of the data base

# you must create a Cursor object. It will let
#  you execute all the query you need
cur = db.cursor() 


server = xmlrpclib.ServerProxy(wp_url)
cur.execute("SELECT id, name, created_at from recipes where active = 1");

recipe_rows = cur.fetchall()
for row in recipe_rows :
    recipe_id =  row[0]
    recipe_name = row[1]
    date_start = row[2]
    categories = []
    
    title = html_escape(recipe_name)
    date_created =  xmlrpclib.DateTime(date_start)
   

    status_draft = 1
    status_published = 0
    
    # Load categories
    cur.execute("select name from categories where id in (select category_id from categorizations where recipe_id = " + str(recipe_id) + ")")
    category_rows = cur.fetchall()
    for c_row in category_rows:
       categories.append(c_row[0])
       #print categories.size()
    tags = categories
    
    
    # Take care of ingredients.
    cur.execute("SELECT measurement_id, grocery_id from ingredients where recipe_id = " + str(recipe_id) + " order by order_num")
    ingredient_rows = cur.fetchall()
    
    
    content = "<strong>Ingredients</strong>\n"
    content += "<ul>\n"
    
    for i_row in ingredient_rows:
       measurement_id = i_row[0]
       grocery_id = i_row[1]
       grocery_name = ""
       measurement_name = ""
       content += "<li>"
       cur.execute("SELECT name from measurements where id = " + str(measurement_id))
       measurement_rows = cur.fetchall()
       for m_row in measurement_rows:
          measurement_name = m_row[0]
       content += html_escape(measurement_name) + " "
       cur.execute("SELECT name from groceries where id = " + str(grocery_id))
       grocery_rows = cur.fetchall()
       for g_row in grocery_rows:
          grocery_name = html_escape(g_row[0])
       content += html_escape(grocery_name)
       content += "</li>\n"
    content += "</ul>\n"
    
    content += "<div><strong>Steps</strong></div>\n"
    content += "<ol>\n"
    
    cur.execute("select instruction from steps where recipe_id = " + str(recipe_id) + " order by order_num")
    steps_rows = cur.fetchall()
    for s_row in steps_rows:
       instruction = s_row[0]
       #print instruction
       if len(instruction) > 0 and not all(c in string.whitespace for c in instruction):
          content += "<li>" + html_escape(instruction) + "</li>\n"
    content += "</ol>\n"
    content += "</div>\n"
    
    data = {'title': title, 'description': content, 'dateCreated': date_created, 'categories': categories, 'mt_keywords': tags}
    try:
       post_id = server.metaWeblog.newPost(wp_blogid, wp_username, wp_password, data, status_published)
    except Exception, e:
       print("ERROR POSTING " + str(recipe_id) + " = " + recipe_name)
       print str(e)
       print "-----------------------------"
sys.exit(1)
    

