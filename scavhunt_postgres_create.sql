-- psql -d postgres://lpklfpzm:5m3B5IB1bjDdOX6mSQLFVv13HXAjHJCQ@ziggy.db.elephantsql.com:5432/lpklfpzm -f scavhunt_postgres_create.sql

drop table public.users CASCADE;
drop table public.hunts CASCADE;
drop table public.events CASCADE;
drop table public.photos CASCADE;
drop table public.subs CASCADE;

CREATE TABLE public.users (
    "user_id" serial NOT NULL,
    "user_name" varchar NOT NULL,
    "password" varchar NOT NULL,
    "current_event_id" int,
    PRIMARY KEY ("user_id")
) WITH (
    OIDS=FALSE
);

CREATE TABLE public.hunts (
    "hunt_id" serial NOT NULL,
    "hunt_name" varchar NOT NULL,
    "hunt_des" varchar NOT NULL,
    "hunt_votes" int, 
    "hunt_banner" varchar,
    "hunt_lat" float,
    "hunt_long" float,
    "user_id" int,
    PRIMARY KEY ("hunt_id")
) WITH (
    OIDS=FALSE
);


CREATE TABLE public.events (
    "event_id" serial NOT NULL,
    "event_name" varchar NOT NULL,
    "event_index" int NOT NULL,
    "event_lat" float NOT NULL,
    "event_long" float NOT NULL, 
    "event_riddle" varchar,
    "hunt_id" int,
    PRIMARY KEY ("event_id")
) WITH (
    OIDS=FALSE
);

CREATE TABLE public.photos (
    "photo_id" serial NOT NULL,
    "photo_src" varchar NOT NULL,
    "user_id" int NOT NULL,
    "event_id" int NOT NULL,
    PRIMARY KEY ("photo_id")
) WITH (
    OIDS=FALSE
);

CREATE TABLE public.subs (
    "sub_id" serial NOT NULL,
    "user_id" int NOT NULL,
    "hunt_id" int NOT NULL,
    "status" varchar NOT NULL,
    PRIMARY KEY ("sub_id")
)  WITH (
    OIDS=FALSE
);


ALTER TABLE public.hunts ADD CONSTRAINT fk_user FOREIGN KEY ("user_id") REFERENCES  public.users("user_id");
ALTER TABLE public.events ADD CONSTRAINT fk_hunt FOREIGN KEY ("hunt_id") REFERENCES  public.hunts("hunt_id");
ALTER TABLE public.photos ADD CONSTRAINT fk_event FOREIGN KEY ("event_id") REFERENCES  public.events("event_id");

ALTER TABLE public.subs ADD CONSTRAINT fk_user FOREIGN KEY ("user_id") REFERENCES public.users("user_id");
ALTER TABLE public.subs ADD CONSTRAINT fk_hunt FOREIGN KEY ("hunt_id") REFERENCES public.hunts("hunt_id");

INSERT INTO public.users (user_name, password) VALUES ('bill', 'nye');
INSERT INTO public.hunts (hunt_name, hunt_des, hunt_votes, hunt_banner, hunt_lat, hunt_long, user_id) VALUES ('Chris D Austin Ultimate', 'Whacky barcrawl around Austin!', 65, '', 30.2674331, -97.7419488, 1);
INSERT INTO public.hunts (hunt_name, hunt_des, hunt_votes, hunt_banner, hunt_lat, hunt_long, user_id) VALUES ('South by Southwest', 'SBSW!', 32, '', 30.2674331, -97.7453488, 1);
INSERT INTO public.events (event_name, event_index, event_lat, event_long, event_riddle, hunt_id) VALUES ('Shakespeare Bar', 0, 30.2674331, -97.7419488, '$7 pitchers and that weird Austin vibe. Take a picture with the ice cream truck.', 1 );
INSERT INTO public.events (event_name, event_index, event_lat, event_long, event_riddle, hunt_id) VALUES ('The Jackalope', 1, 30.2671304, -97.7411892, 'Take a picture with the DJ.', 1 );
INSERT INTO public.events (event_name, event_index, event_lat, event_long, event_riddle, hunt_id) VALUES ('YETI Austin Flagship', 2, 30.2593641, -97.7485306, 'Didnt know the cooler brand had a bar? Cross the river to see it. Take a picture with the yeti.', 1 );

INSERT INTO public.photos (photo_src, event_id, user_id) VALUES ('https://assets3.thrillist.com/v1/image/1191380/1584x1056/crop;jpeg_quality=60;progressive.jpg', 1, 1);

INSERT INTO public.subs (user_id, hunt_id, status) VALUES (1, 1, 'SIGNED UP')