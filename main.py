import subprocess
import shutil
import os
import sys

class LatexProjectCompiler:
    def __init__(self, project_name='document', main_tex_name='examGenerator.tex', pdf_name='examGenerator.pdf'):
        self.workspace_dir = os.getcwd()
        self.project_dir = os.path.join(self.workspace_dir, project_name)
        self.output_dir = os.path.join(self.workspace_dir, 'output')
        self.logs_dir = os.path.join(self.workspace_dir, '__logs__')
        # Allow passing a main tex path relative to the project or an absolute path
        if os.path.isabs(main_tex_name):
            self.main_tex = main_tex_name
        else:
            self.main_tex = os.path.join(self.project_dir, main_tex_name)
        self.pdf_name = pdf_name
        self.pdf_path = os.path.join(self.project_dir, pdf_name)
        self.output_pdf_path = os.path.join(self.output_dir, pdf_name)
        self.aux_files = [f'{os.path.splitext(pdf_name)[0]}.{ext}' for ext in ['aux', 'log', 'out', 'toc']]
        # # RNGNull setup
        # self.questions_src = os.path.join(self.project_dir, 'examples', 'questions.tex')
        # self.questions_temp = os.path.join(self.project_dir, 'examples', 'questions_temp.tex')
        # self.rngnull = RNGNull(self.questions_src, self.questions_temp)

    def ensure_directories(self):
        os.makedirs(self.output_dir, exist_ok=True)
        os.makedirs(self.logs_dir, exist_ok=True)

    def compile_latex(self):
        error_occurred = False
        for _ in range(2):
            try:
                subprocess.run([
                    'pdflatex',
                    '-interaction=nonstopmode',
                    '-output-directory', self.project_dir,
                    self.main_tex
                ], cwd=self.project_dir, check=True)
            except subprocess.CalledProcessError as e:
                print(f"LaTeX compilation error (exit code {e.returncode}). Attempting to move PDF if it exists...")
                error_occurred = True
                break
        return error_occurred

    def move_pdf(self, error_occurred):
        if os.path.exists(self.pdf_path):
            shutil.move(self.pdf_path, self.output_pdf_path)
            print(f"PDF generated at: {self.output_pdf_path}")
            if error_occurred:
                print("Warning: LaTeX compilation returned an error, but PDF was generated and moved.")
        else:
            print("PDF not found. Compilation may have failed.")

    def move_aux_files(self):
        # Move standard aux files
        for fname in self.aux_files:
            src = os.path.join(self.project_dir, fname)
            dst = os.path.join(self.logs_dir, fname)
            if os.path.exists(src):
                shutil.move(src, dst)
                print(f"Moved {fname} to __logs__ directory.")
        # Also move project-related run files (e.g., main.bcf, main.run.xml)
        base_name = os.path.splitext(os.path.basename(self.main_tex))[0]
        extra_files = [f"{base_name}.bcf", f"{base_name}.run.xml"]
        for fname in extra_files:
            src = os.path.join(self.project_dir, fname)
            dst = os.path.join(self.logs_dir, fname)
            if os.path.exists(src):
                shutil.move(src, dst)
                print(f"Moved {fname} to __logs__ directory.")

    def run(self):
        self.ensure_directories()
        orig_questions = os.path.join(self.project_dir, 'examples', 'questions.tex')
        backup_questions = orig_questions + '.bak'
        backup_created = False
        if os.path.exists(orig_questions):
            shutil.copy2(orig_questions, backup_questions)
            backup_created = True
        try:
            error_occurred = self.compile_latex()
            self.move_pdf(error_occurred)
            self.move_aux_files()
        finally:
            if backup_created and os.path.exists(backup_questions):
                shutil.move(backup_questions, orig_questions)

class ArgC:
    def __init__(self, args):
        self.args = args

    def outputFlag(self):
        return '-o' in self.args

    def outputPath(self):
        if self.outputFlag():
            idx = self.args.index('-o')
            if idx + 1 < len(self.args):
                return self.args[idx + 1]
        return None

    def mainTex(self):
        for arg in self.args:
            if arg.endswith('.tex'):
                return arg
        return None

    def projectFolder(self):
        for arg in self.args:
            if not arg.startswith('-') and not arg.endswith('.tex') and not arg.endswith('.pdf'):
                return arg
        return None

    def pdfName(self):
        for arg in self.args:
            if arg.endswith('.pdf'):
                return arg
        return None

if __name__ == "__main__":
    args = ArgC(sys.argv[1:])
    folder = args.projectFolder() or 'document'
    pdf_name = args.pdfName() or f'{folder}.pdf'

    main_tex = args.mainTex() or 'examGenerator.tex'
    compiler = LatexProjectCompiler(project_name=folder, main_tex_name=main_tex, pdf_name=pdf_name)
    compiler.run()