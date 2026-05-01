import ffmpeg
import os
import sys

def check_mp4_integrity(file_path):
        """Check MP4 integrity using ffmpeg-python."""
            try:
                        ffmpeg.input(file_path).output('null', f='null').run(capture_stderr=True)
                                print(f"{file_path}: No integrity issues found.")
                                        return True, None
                                        except ffmpeg.Error as e:
                                                    print(f"{file_path}: Errors found in file integrity:")
                                                            error_message = e.stderr.decode()
                                                                    print(error_message)
                                                                            return False, error_message

                                                                        def fix_mp4_file(input_path, output_path):
                                                                                """Fix MP4 file by re-encoding using ffmpeg-python."""
                                                                                    ffmpeg.input(input_path).output(output_path, vcodec='copy', acodec='copy').run()
                                                                                        print(f"File fixed and saved as {output_path}")

                                                                                        if __name__ == "__main__":
                                                                                                if len(sys.argv) > 1:
                                                                                                            files_to_check = sys.argv[1:]
                                                                                                                else:
                                                                                                                            files_to_check = [f for f in os.listdir('.') if f.lower().endswith('.mp4')]

                                                                                                                                for input_file in files_to_check:
                                                                                                                                            output_file = f"fixed_{input_file}"

                                                                                                                                                    if not os.path.exists(input_file):
                                                                                                                                                                    print(f"File {input_file} does not exist.")
                                                                                                                                                                                continue

                                                                                                                                                                                    integrity_ok, errors = check_mp4_integrity(input_file)

                                                                                                                                                                                            if not integrity_ok:
                                                                                                                                                                                                            user_input = input(f"Do you want to attempt to fix '{input_file}'? (y/n): ").lower()
                                                                                                                                                                                                                        if user_input == 'y':
                                                                                                                                                                                                                                            fix_mp4_file(input_file, output_file)
                                                                                                                                                                                                                                                        else:
                                                                                                                                                                                                                                                                            print("Fix cancelled by user.")
                                                                                                                                                                                                                                                                                    else:
                                                                                                                                                                                                                                                                                                    print(f"{input_file}: No fix needed.")

