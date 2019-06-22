import sys
import json

# Get the user-specified notebook files.
nbs = sys.argv[1:]

for nb in nbs:
    # Open the original notebook.
    with open(nb, 'r') as f:
        contents = f.read()
    contents = json.loads(contents)
    # Find cells that aren't labeled as a slide type and make them slides.
    cells = contents['cells']
    for cell in cells:
        if 'slideshow' not in cell['metadata']:
            cell['metadata']['slideshow'] = {'slide_type': 'slide'}
    # Write the updated notebook back out.
    with open(nb, 'w') as f:
        contents = json.dumps(contents)
        f.write(contents)
