module Fastlane
  module Actions
    module SharedValues
      TEST_ACTION_CUSTOM_VALUE = :TEST_ACTION_CUSTOM_VALUE
    end

    class SelectSpecificAssetsAction < Action

		class YamlReader
			def initialize(yaml_path)
			  @yamlFile = YAML.load_file(yaml_path)
			end
		
			def field(fieldName)
			  @yamlFile[fieldName]
			end
		
			def all
			  @yamlFile
			end
		  end
		
		  class YamlWritter
			def initialize(yaml_path)
			  @yaml_path = yaml_path
			end
		
			def write(yaml)
			  File.open(@yaml_path, "w") { |file| file.write(yaml.to_yaml) }
			end
		  end
		
		  class FileReader
			def initialize(yaml_path)
			  @yaml_path = yaml_path
			end
		
			def read
			  IO.readlines(@yaml_path)
			end
		  end

      def self.run(params)

		UI.message("Selecting specific assets for flags #{params[:flags]}")

		@pubspec_yaml_writter = YamlWritter.new("/Users/armanddidierjean/Documents/Git/Titan/pubspec_exp.yaml")
        @pubspec_yaml_reader = YamlReader.new("/Users/armanddidierjean/Documents/Git/Titan/pubspec.yaml")

		context = @pubspec_yaml_reader.all

		UI.message("Found assets #{context["flutter"]["assets"]}")
		UI.message("Found specific #{context["specific"]["assets"]}")
		UI.message("Running for flags #{params[:flags]}")

		for asset in context["flutter"]["assets"] do
     
			# If the asset is included in the specific assets list
			# we want to check if it should be included in this particular flavor of the app
			if context["specific"]["assets"][asset] then
				# If there is no intersection between the flags and the asset's list of flags we want to remove the asset from the pubspec
				if context["specific"]["assets"][asset] & params[:flags] == [] then
					UI.message("Removing asset #{asset} from the pubspec")
					context["flutter"]["assets"].delete(asset)
				end
			end
			 
		   end

		#
        @pubspec_yaml_writter.write(context)

        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::TEST_ACTION_CUSTOM_VALUE] = "my_val"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'A short description with <= 80 characters of what this action does'
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        'You can use this action to do cool things...'
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [

		  FastlaneCore::ConfigItem.new(key: :flags,
                                       # The name of the environment variable
                                       env_name: 'FL_TEST_ACTION_FLAGS',
                                       # a short description of this parameter
                                       description: 'A list of flags describing the flavor of the application being compiled',
									   is_string: false,
									   default_value: []
                                    #    verify_block: proc do |value|
                                    #      unless value && !value.empty?
                                    #        UI.user_error!("No API token for TestActionAction given, pass using `api_token: 'token'`")
                                    #      end
                                         # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                      #end
									   ),
        #   FastlaneCore::ConfigItem.new(key: :api_token,
        #                                # The name of the environment variable
        #                                env_name: 'FL_TEST_ACTION_API_TOKEN',
        #                                # a short description of this parameter
        #                                description: 'API Token for TestActionAction',
        #                                verify_block: proc do |value|
        #                                  unless value && !value.empty?
        #                                    UI.user_error!("No API token for TestActionAction given, pass using `api_token: 'token'`")
        #                                  end
        #                                  # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
        #                                end),
        #   FastlaneCore::ConfigItem.new(key: :development,
        #                                env_name: 'FL_TEST_ACTION_DEVELOPMENT',
        #                                description: 'Create a development certificate instead of a distribution one',
        #                                # true: verifies the input is a string, false: every kind of value
        #                                is_string: false,
        #                                # the default value if the user didn't provide one
        #                                default_value: false)
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['TEST_ACTION_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ['armanddidierjean']
      end

      def self.is_supported?(platform)
        # you can do things like
        #
        #  true
        #
        #  platform == :ios
        #
        #  [:ios, :mac].include?(platform)
        #

        platform == :ios
      end
    end
  end
end
