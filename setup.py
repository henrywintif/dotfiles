import argparse
import os
from subprocess import call
from typing import List

def init_argparse() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Used to install or uninstall the dotfiles"
    )
    parser.add_argument(
        "command",
        nargs=1,
        required=True,
        choices=['install', 'i', 'uninstall', 'u']
    )


def dependencies_met() -> int:
    deps = [
        'stowsh'
    ]
    unmet_deps = []
    for dep in deps:
        if call(f'which {dep}') > 0:
            unmet_deps.append(dep)
    if len(unmet_deps) > 0:
        print(f'Please install unmet dependencies: {str(unmet_deps)}')
        return 1
    return 0


def get_config_dirs() -> List[str]:
    abspath = os.path.abspath(__file__)
    dirname = os.path.dirname(abspath)
    return [filename for filename in os.listdir(dirname) if os.path.isdir(os.path.join(dirname, filename))]


def install() -> int:
    os.chdir(os.path.expanduser('~'))
    """Change to home dir"""
    call(['stowsh', '-n'] + get_config_dirs())
    return 0


def uninstall() -> int:
    return 0


def main() -> None:
    dependencies_status = dependencies_met()
    if dependencies_status > 0:
        exit(dependencies_status)

    parser = init_argparse()
    args = parser.parse_args()

    if args.command[0] == 'i':
        exit(install())

    if args.command[0] == 'u':
        exit(uninstall())

    print('Proper command not given. Run with -h to see help info.')
    exit(0)

if __name__ == '__main__':
    main()
