import sys
import re


ITEM_RE = r'\* .*\n(?:  .*\n|\s*\n)*'


def author(bullet):
    """Given a Markdown bullet, return the last name of the first author.
    """
    authors = bullet.split('\n')[1]
    authors, _ = authors.split('(', 1)
    names = [n.strip() for n in re.split(', and |, | and ', authors)]
    return names[0].split()[-1]


def sortpapers(infile=sys.stdin, outfile=sys.stdout):
    doc = infile.read()

    # Find a Markdown list in the document.
    m = re.search(r'({})+'.format(ITEM_RE), doc)
    all_items = m.group(0)
    prefix = doc[:m.start()]
    suffix = doc[m.end():]

    # Sort the bullets.
    items = re.findall(ITEM_RE, all_items)
    items.sort(key=author)

    # Stitch the document back together.
    outfile.write(prefix + ''.join(items) + suffix)


if __name__ == '__main__':
    sortpapers()
