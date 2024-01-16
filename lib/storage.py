
class CloudStorage:
    def __init__(self): # admin has unlimited storage capacity
        self.users = {"admin" : float("inf")}
        self.storage = {}

    def add_user(self, user_id, capacity):
        if user_id in self.users:
            return "false"
        else:
            self.users[user_id] = int(capacity)
            return "true"


    def add_file_by(self, user_id, name, size):
        if user_id not in self.users or user_id == "admin":
            return ""

        user_capacity = self.users[user_id]
        file_size = int(size)

        if user_id in self.storage:
            user_files_size = sum(self.storage[user_id].values())
        else:
            user_files_size = 0

        if user_files_size + file_size <= user_capacity:
            if user_id not in self.storage:
                self.storage[user_id] = {}

            self.storage[user_id][name] = file_size
            remaining_capacity = user_capacity - (user_files_size + file_size)
            return str(remaining_capacity)
        else:
            return ""


    def merge_user(self, user_id_1, user_id_2):
        if user_id_1 == user_id_2 or user_id_1 not in self.users or user_id_2 not in self.users:
            return ""

        x = self.storage[user_id_2]
        if user_id_2 in self.storage:
            if user_id_1 not in self.storage:
                self.storage[user_id_1] = {}

            self.storage[user_id_1].update(self.storage[user_id_2])
            del self.storage[user_id_2]



        remaining_capacity = self.users[user_id_1] +  self.users[user_id_2]
        del self.users[user_id_2]
        self.users[user_id_1] = remaining_capacity


        # return str(rem_user_1 + rem_user_2)
        return str(remaining_capacity)

    def add_file(self, name, size):
        for user_id, files in self.storage.items():
            if name in files:
                return "false"

        self.storage["admin"] = self.storage.get("admin",{})
        self.storage["admin"][name] = int(size)
        return "true"

    def get_file_size(self, name):
        for user_id, files in self.storage.items():
            if name in files:
                return str(files[name])
        else:
            return ""

    def delete_file(self, name):
        for user_id, files in self.storage.items():
            if name in files:
                size = files.pop(name)
                return str(size)
        return ""

    def get_n_largest(self, prefix, n):
        matching_files = [(user_id, name, size) for user_id, files in self.storage.items() for name, size in files.items() if name.startswith(prefix)]
        # custom sort : sort by file size in desc -> -x[1]
        # if tie, use file name for breaking tie, x[0]
        matching_files.sort(key = lambda x: (-x[2],x[1],x[0]))

        result_files = matching_files[:n]

        if not result_files:
            return ""

        result_str = ", ".join([f"{name}({size})" for user_id, name, size in result_files])

        return result_str



def solution(queries):

    cloud_storage = CloudStorage()
    results = []

    for query in queries:
        operation = query[0]
        name = query[1]

        if operation == "ADD_FILE":
            size = query[2]
            result = cloud_storage.add_file(name, size)

        elif operation == "GET_FILE_SIZE":
            result = cloud_storage.get_file_size(name)

        elif operation == "DELETE_FILE":
            result= cloud_storage.delete_file(name)

        elif operation == "GET_N_LARGEST":
            n = int(query[2])
            result = cloud_storage.get_n_largest(name, n)

        elif operation == "ADD_USER":
            user_id = query[1]
            capacity = query[2]
            result = cloud_storage.add_user(user_id, capacity)

        elif operation == "ADD_FILE_BY":
            user_id = query[1]
            name = query[2]
            size = query[3]
            result = cloud_storage.add_file_by(user_id, name, size)

        elif operation == "MERGE_USER":
            user_id_1 = query[1]
            user_id_2 = query[2]

            result = cloud_storage.merge_user(user_id_1, user_id_2)

        results.append(result)

    return results