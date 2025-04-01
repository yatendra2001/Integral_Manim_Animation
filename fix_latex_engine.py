#!/usr/bin/env python3
"""
This script modifies Manim's TeX template to use pdflatex instead of latex.
This can help resolve certain LaTeX compilation issues.
"""

import os
import sys
import manim

def fix_tex_template():
    # Find the manim package location
    manim_path = os.path.dirname(manim.__file__)
    print(f"Manim is installed at: {manim_path}")
    
    # Find the tex_template.tex file
    template_path = os.path.join(manim_path, "utils", "tex_templates", "tex_template.tex")
    if not os.path.exists(template_path):
        print(f"Could not find tex_template.tex at {template_path}")
        template_dirs = []
        for root, dirs, files in os.walk(manim_path):
            if "tex_template.tex" in files:
                template_dirs.append(os.path.join(root, "tex_template.tex"))
        
        if not template_dirs:
            print("Could not find any tex_template.tex file in the manim installation.")
            return False
        
        print(f"Found alternative template locations: {template_dirs}")
        template_path = template_dirs[0]
    
    print(f"Using template at: {template_path}")
    
    # Read the current template
    with open(template_path, 'r') as f:
        template_content = f.read()
    
    # Create a backup
    backup_path = template_path + ".backup"
    if not os.path.exists(backup_path):
        with open(backup_path, 'w') as f:
            f.write(template_content)
        print(f"Created backup at {backup_path}")
    
    # Modify the template to use pdflatex
    modified = False
    if "\\documentclass[preview]{standalone}" in template_content:
        template_content = template_content.replace(
            "\\documentclass[preview]{standalone}",
            "\\documentclass[preview,12pt]{standalone}"
        )
        modified = True
    
    if modified:
        with open(template_path, 'w') as f:
            f.write(template_content)
        print("Successfully modified the TeX template.")
        return True
    else:
        print("No modifications needed or template has unexpected format.")
        return False

if __name__ == "__main__":
    success = fix_tex_template()
    if success:
        print("TeX template has been modified to improve compatibility.")
        print("You can now try running the animation again.")
    else:
        print("Could not modify the TeX template. Check the errors above.")
    
    print("\nTo restore the original template, run:")
    print("  python3 -c \"import os,manim; os.rename(os.path.join(os.path.dirname(manim.__file__), 'utils', 'tex_templates', 'tex_template.tex.backup'), os.path.join(os.path.dirname(manim.__file__), 'utils', 'tex_templates', 'tex_template.tex'))\"") 