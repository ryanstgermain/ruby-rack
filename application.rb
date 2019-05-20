class Application
    def call(env)
        if env["PATH_INFO"] == "/users"
            [200, {}, [Database.users.to_s]]
        end
    end
end
