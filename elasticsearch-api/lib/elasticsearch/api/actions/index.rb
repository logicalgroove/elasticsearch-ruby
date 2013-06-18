module Elasticsearch
  module API
    module Actions

      # Create or update a document.
      #
      # The `index` API will either _create_ a new document, or _update_ an existing one, when a document `:id`
      # is passed. When creating a document, an ID will be auto-generated, when it's not passed as an argument.
      #
      # You can specifically enforce the _create_ operation by settint the `op_type` argument to `create`, or
      # by using the {Actions#create} method.
      #
      # Optimistic concurrency control is performed, when the `version` argument is specified. By default,
      # no version checks are performed.
      #
      # By default, the document will be available for {Actions#get} immediately, for {Actions#search} only
      # after an index refresh operation has been performed (either automatically or manually).
      #
      # @option arguments [String] :id Document ID (optional, will be auto-generated if missing)
      # @option arguments [String] :index The name of the index (*Required*)
      # @option arguments [String] :type The type of the document (*Required*)
      # @option arguments [Hash] :body The document
      # @option arguments [String] :consistency Explicit write consistency setting for the operation
      #                                         (options: one, quorum, all)
      # @option arguments [String] :op_type Explicit operation type (options: index, create)
      # @option arguments [String] :parent ID of the parent document
      # @option arguments [String] :percolate Percolator queries to execute while indexing the document
      # @option arguments [Boolean] :refresh Refresh the index after performing the operation
      # @option arguments [String] :replication Specific replication type (options: sync, async)
      # @option arguments [String] :routing Specific routing value
      # @option arguments [Time] :timeout Explicit operation timeout
      # @option arguments [Time] :timestamp Explicit timestamp for the document
      # @option arguments [Duration] :ttl Expiration time for the document
      # @option arguments [Number] :version Explicit version number for concurrency control
      # @option arguments [String] :version_type Specific version type (options: internal, external)
      #
      # @see http://elasticsearch.org/guide/reference/api/index_/
      #
      def index(arguments={})
        raise ArgumentError, "Required argument 'index' missing" unless arguments[:index]
        raise ArgumentError, "Required argument 'type' missing" unless arguments[:type]
        method = arguments[:id] ? 'PUT' : 'POST'
        path   = Utils.__pathify( arguments[:index], arguments[:type], arguments[:id] )
        params = arguments.select do |k,v|
          [ :consistency,
            :id,
            :op_type,
            :parent,
            :percolate,
            :refresh,
            :replication,
            :routing,
            :timeout,
            :timestamp,
            :ttl,
            :version,
            :version_type ].include?(k)
        end
        # Normalize Ruby 1.8 and Ruby 1.9 Hash#select behaviour
        params = Hash[params] unless params.is_a?(Hash)

        # params.update :op_type => 'create'

        body   = arguments[:body]

        perform_request(method, path, params, body).body
      end
    end
  end
end
