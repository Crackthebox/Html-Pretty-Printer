# HTML Pretty Printer & Syntax Validator (Bash)

A lightweight and efficient command-line utility written in Bash that intelligently parses, indents, and validates HTML files. This tool transforms minified or messy HTML into a human-readable format while checking for structural integrity.

## 🚀 Features
* **Intelligent Indentation:** Automatically calculates nesting levels and applies clean tabbing (4 spaces) based on the document tree.
* **HTML5 Void Tag Awareness:** Recognizes self-closing and void tags (e.g., `<img>`, `<br>`, `<input>`) to maintain accurate indentation logic.
* **Structural Validation:** Analyzes the balance of opening and closing tags. If the HTML is syntactically invalid (unclosed tags), the script alerts the user and prevents corrupted output.
* **Automated Formatting:** Separates tags and content into distinct lines for maximum readability using `awk` and `sed` processing.

## 🛠️ Tech Stack
* **Shell Scripting:** Bash
* **Text Processing Tools:** `sed`, `awk`, `grep` (Regex-based parsing).
* **Linux Environment:** Utilizes temporary system buffers (`mktemp`) for efficient processing.

## 📖 Usage
1. Give execution permissions: `chmod +x html_pretty_printer.sh`
2. Run the script: `./html_pretty_printer.sh your_file.html`
3. The formatted file will be saved as `your_file_formatted.html`.

## 🌍 Educational Context
This project demonstrates advanced knowledge of Linux CLI tools and regular expressions, focusing on creating developer utilities that improve code maintainability.
