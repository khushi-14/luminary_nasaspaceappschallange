from flask import Flask
from flask_restful import Api, Resource, reqparse, abort, fields, marshal_with
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
api = Api(app)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'
db = SQLAlchemy(app)

# db.create_all()

class DataModel(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    lastupdate = db.Column(db.String(100), nullable=True)
    elapseddays = db.Column(db.String(100), nullable=True)
    distfromsun = db.Column(db.String(100), nullable=True)
    velocity = db.Column(db.String(100), nullable=True)
    
    def __repr__(self):
        return f"CurrentData(lastupdate = {lastupdate}, elapseddays = {elapseddays}, distfromsun = {distfromsun}, velocity = {velocity})"

class FeatureModel(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=True)
    url = db.Column(db.String(100), nullable=True)
    time = db.Column(db.String(100), nullable=True)
    desc = db.Column(db.String(100), nullable=True)
    
    def __repr__(self):
        return f"CurrentData(title = {title}, url = {url}, time = {time}, desc = {desc})"


db.create_all()
data_put_args = reqparse.RequestParser()
data_put_args.add_argument("lastupdate", type=str, help="lastupdate", required=True)
data_put_args.add_argument("elapseddays", type=str, help="elapseddays", required=True)
data_put_args.add_argument("distfromsun", type=str, help="distfromsun", required=True)
data_put_args.add_argument("velocity", type=str, help="velocity", required=True)

data_update_args = reqparse.RequestParser()
data_update_args.add_argument("lastupdate", type=str, help="lastupdate", required=True)
data_update_args.add_argument("elapseddays", type=str, help="elapseddays", required=True)
data_update_args.add_argument("distfromsun", type=str, help="distfromsun", required=True)
data_update_args.add_argument("velocity", type=str, help="velocity", required=True)

feature_put_args = reqparse.RequestParser()
feature_put_args.add_argument("title", type=str, help="title", required=True)
feature_put_args.add_argument("url", type=str, help="url", required=True)
feature_put_args.add_argument("time", type=str, help="time", required=True)
feature_put_args.add_argument("desc", type=str, help="desc", required=True)

feature_update_args = reqparse.RequestParser()
feature_update_args.add_argument("title", type=str, help="title", required=True)
feature_update_args.add_argument("url", type=str, help="url", required=True)
feature_update_args.add_argument("time", type=str, help="time", required=True)
feature_update_args.add_argument("desc", type=str, help="desc", required=True)


resource_fields = {
    'id': fields.Integer,
	'lastupdate': fields.String,
	'elapseddays': fields.String,
	'distfromsun': fields.String,
	'velocity': fields.String
}

resource_fields2 = {
    'id': fields.Integer,
	'title': fields.String,
	'url': fields.String,
	'time': fields.String,
	'desc': fields.String
}

class CurrentData(Resource):
    @marshal_with(resource_fields)
    def get(self,did):
        result = DataModel.query.filter_by(id=did).first()
        if not result:
            abort(404, message="Could not find video with that id")
        return result

    @marshal_with(resource_fields)
    def put(self,did):
        args = data_put_args.parse_args()
        data = DataModel(id=did,lastupdate=args['lastupdate'], elapseddays=args['elapseddays'], distfromsun=args['distfromsun'], velocity=args['velocity'])
        db.session.add(data)
        db.session.commit()
        return data, 201

    @marshal_with(resource_fields)
    def patch(self, did):
        args = data_update_args.parse_args()
        result = DataModel.query.filter_by(id=did).first()
        if not result:
            abort(404, message="Video doesn't exist, cannot update")
        if args['lastupdate']:
            result.lastupdate = args['lastupdate']
        if args['elapseddays']:
            result.elapseddays = args['elapseddays']
        if args['distfromsun']:
            result.distfromsun = args['distfromsun']
        if args['velocity']:
            result.velocity = args['velocity']
        db.session.commit()
        return result


class FeatureData(Resource):
    @marshal_with(resource_fields2)
    def get(self,fid):
        result = FeatureModel.query.filter_by(id=fid).first()
        if not result:
            abort(404, message="Could not find video with that id")
        return result

    @marshal_with(resource_fields2)
    def put(self,fid):
        args = feature_put_args.parse_args()
        data = FeatureModel(id=fid,title=args['title'], url=args['url'], time=args['time'], desc=args['desc'])
        db.session.add(data)
        db.session.commit()
        return data, 201

    @marshal_with(resource_fields2)
    def patch(self, fid):
        args = feature_update_args.parse_args()
        result = FeatureModel.query.filter_by(id=fid).first()
        if not result:
            abort(404, message="Video doesn't exist, cannot update")
        if args['title']:
            result.title = args['title']
        if args['url']:
            result.url = args['url']
        if args['time']:
            result.time = args['time']
        if args['desc']:
            result.desc = args['desc']
        db.session.commit()
        return result

class FeatureDataGet(Resource):
    @marshal_with(resource_fields2)
    def get(self):
        result = FeatureModel.query.all()
        if not result:
            abort(404, message="Could not find video with that id")
        return result


api.add_resource(CurrentData,"/currentdata/<int:did>")
api.add_resource(FeatureData,"/featuredata/<int:fid>")
api.add_resource(FeatureDataGet,"/featuredataall")

if __name__ == "__main__":
    db.create_all()
    app.run()