
def get_sizes(elem):
    splited = elem.split(' ')
    rectangle_size = splited[-1].split('x')
    rectangle_size = list(map(int, rectangle_size))
    distance_from_edges = splited[-2].split(',')
    distance_from_edges[1] = distance_from_edges[1][:-1]
    distance_from_edges = list(map(int, distance_from_edges))
    return rectangle_size, distance_from_edges


def get_max_size_elem(elem):
    rectangle_size, distance_from_edges = get_sizes(elem)
    return (rectangle_size[0] + distance_from_edges[0], rectangle_size[1] + distance_from_edges[1])


def get_max_board_size(lines):
    maximums = list(map(get_max_size_elem, lines))
    globalMaxX = 0
    gobalMaxY = 0
    for i, j in maximums:
        globalMaxX = max(i, globalMaxX)
        globalMaxY = max(j, globalMaxX)
    return (globalMaxX, globalMaxY)


def populate_board(line, line_number, board, s):
    no_overlap = True
    rectangle_size, distance_from_edges = get_sizes(line)
    for i in range(distance_from_edges[0], distance_from_edges[0] + rectangle_size[0]):
        for j in range(distance_from_edges[1], distance_from_edges[1] + rectangle_size[1]):
            board[i][j].append(line_number)
            if(len(board[i][j]) > 1):
                no_overlap = False
                for overlapped in board[i][j]:
                    s.discard(overlapped)
    if no_overlap:
        s.add(line_number)
    return board


def count_intersections(board):
    total = 0
    for i in board:
        for elem in i:
            if len(elem) >= 2:
                total +=1
    return total


if __name__ == '__main__':
    with open('input', 'r') as inp:
        lines = inp.readlines()
    board_boundaries = get_max_board_size(lines)
    board = [[[] for i in range(board_boundaries[0])] for j in range(board_boundaries[1])]
    not_overlapped = set()
    for i, line in enumerate(lines):
        board = populate_board(line, i+1, board, not_overlapped)
    # Part 1
    print(count_intersections(board))
    # Part 2
    print("Not overlapped: ", not_overlapped)

