from lxml import etree
from xml.dom import minidom
import sys

root_node = etree.Element("root")
courses_node = etree.SubElement(root_node,"courses")



root = etree.parse(sys.stdin)
course_blocks = root.xpath('//LTTextBoxHorizontal')
for course_block in course_blocks:
    course_node = etree.SubElement(courses_node,"course")
    course_text = course_block.xpath('.//LTTextLineHorizontal')
    if(course_text):
        course_name = course_text[0]
        course_name_text = course_name.xpath('./text()')[0]
        etree.SubElement(course_node,"name").text = course_name_text
        prereq = course_block.xpath('.//LTTextLineHorizontal[contains(text(),"Prerequisite")]')
        if(prereq):
            prereq_text = prereq[0].xpath('./text()')[0]
            rest = prereq[0].xpath('following-sibling::LTTextLineHorizontal')
            for datum in rest:
                prereq_text += datum.xpath('./text()')[0]
            etree.SubElement(course_node,"prerequisite").text = prereq_text

#tree = etree.ElementTree(root_node)
#tree.write("parsed_prerequisites.xml")

xmlstr = minidom.parseString(etree.tostring(root_node)).toprettyxml(indent="    ")
sys.stdout.write(xmlstr)

        